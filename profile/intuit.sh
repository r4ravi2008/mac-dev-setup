alias spark-ui="ssh -CNg -D 127.0.0.1:8157 prod_bastion"
alias spark-ui-preprod="ssh -CNg -D 127.0.0.1:8157 preprod_bastion"
# prod account =  473156531564 
# pre prod account = 515292565807
 
function generateAWSCreds() {
    echo "Generating aws credentials for account: $1, for role: $2, for aws profile: $3"
    export AWS_DEFAULT_PROFILE=$3
    eiamCli aws_creds -a $1 -r $2 -p $3
}

function assumeCreds() {
    CURRENT_ARN=`aws sts get-caller-identity | jq '.Arn'`
    echo "$CURRENT_ARN assuming $1"
    RANDOM_ID=`date +%s | cksum | base64 | head -c 5 | tr '[:upper:]' '[:lower:]'`
    temp_role=$(aws sts assume-role --role-arn ${1} --role-session-name rkommineni-$RANDOM_ID)
    export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Credentials.AccessKeyId | xargs)
    export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq .Credentials.SecretAccessKey | xargs)
    export AWS_SESSION_TOKEN=$(echo $temp_role | jq .Credentials.SessionToken | xargs)
}

function eLogin(){
    eiamCli login -- 
}

function sshCert() {
    echo "Generating ssh certs for account: $1"
    eiamCli aws_ssh -a $1 -p intuit_github.pub -d ~/.ssh 
}

function search-ec2-instance() {
    aws ec2 describe-instances --filter "Name=tag:Name,Values=*$1*" | jq '.Reservations[].Instances[]
    | {
        instanceId: .InstanceId,
        instanceType: .InstanceType,
        instanceProfile: .IamInstanceProfile.Arn,
        launchTime: .LaunchTime,
        billing:. | .Tags? | map(select(.Key == "intuit:billing:user-app")) ,
        Name:. | .Tags? | map(select(.Key == "Name")) ,
        app:. | .Tags? | map(select(.Key == "app"))
      }'
}

function search-ec2-instance-by-id() {
    aws ec2 describe-instances --instance-ids $1
}


function list-emrs () {
    if [[ "$2" == "terminated" ]]
    then
       aws emr list-clusters --$2  --created-after $1 --query 'Clusters[*].[Id, Name, Status.State, Status.Timeline.CreationDateTime, Status.Timeline.EndDateTime, NormalizedInstanceHours]' |
          TZ=america/los_angeles jq -r '.[] | {id: .[0], name: .[1], status: .[2], created: (.[3] |  strflocaltime("%Y-%m-%d %H:%M:%S %Z")), terminated: (.[4] | strflocaltime("%Y-%m-%d %H:%M:%S %Z"))} '
    else
        aws emr list-clusters --$2  --created-after $1 --query 'Clusters[*].[Id, Name, Status.State, Status.Timeline.CreationDateTime, Status.Timeline.EndDateTime, NormalizedInstanceHours]' |
          TZ=america/los_angeles jq -r '.[] | {id: .[0], name: .[1], status: .[2], normalizedHours: .[5], created: (.[3] |  strflocaltime("%Y-%m-%d %H:%M:%S %Z")) } '
    fi

}

function get-emr-master-node-ip() {
    aws emr describe-cluster --cluster-id $1 |grep MasterPublicDnsName | tr '-' '.' | awk -F "." '{print $2 "." $3 "." $4 "." $5}'
}

function search-provisioned-product() {
    aws servicecatalog search-provisioned-products --filter SearchQuery="$1"  --query 'ProvisionedProducts[*].{Name:Name, Id:Id, Status:Status}'
}

function terminate-provisioned-product() {
    aws servicecatalog terminate-provisioned-product --provisioned-product-id $1
}

function report-for-emr() {
    list-emr-steps $1  | jq -s '.' | jq -r '. | map([.name, .status, .duration] | join(",")) | join("\n")'
}

function list-emr-steps() {
    aws emr list-steps --cluster-id $1 | jq '.Steps[] | {name: .Name, status: .Status.State, duration: ((.Status.Timeline.EndDateTime - .Status.Timeline.StartDateTime)/60) } '
}

function get-ec2-details() {
aws ec2 describe-instances --instance-ids "$@" | jq '
    .Reservations[].Instances[]
    | {
        instanceId: .InstanceId,
        instanceType: .InstanceType,
        instanceProfile: .IamInstanceProfile.Arn,
        launchTime: .LaunchTime,
        billing:. | .Tags? | map(select(.Key == "intuit:billing:user-app")) ,
        app:. | .Tags? | map(select(.Key == "app"))
      }'
}

function setup-jupyter-tunnel() {
    echo "Using cluster $1"
    local ip=$(get-emr-master-node-ip $1)
    echo "ssh $ip -L 8998:$ip:8998"
    ssh $ip -L 8998:$ip:8998 -N
}
