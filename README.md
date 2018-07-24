# localstack_ngrep

This repo hosts the build file for a docker image that wraps
the base localstack image, providing the `ngrep` utility for
troubleshooting AWS api calls made to localstack.

## Usage
Launch the localstack_ngrep container (easiest using docker compose):

```
$ docker-compose up
```

Use `docker ps` to get the name/id of the running container:
```
$ docker ps | grep 'wolfgangmeyers/localstack_ngrep'
3ef6e38e7166        wolfgangmeyers/localstack_ngrep   "/usr/bin/supervisor…"   8 minutes ago       Up 8 minutes        4567-4568/tcp, 0.0.0.0:4569->4569/tcp, 4570-4571/tcp, 4573-4583/tcp, 8080/tcp, 0.0.0.0:4572->4572/tcp   hello_localstack_1
```

In a separate terminal, attach to the running container and launch ngrep:
```
docker exec -it hello_localstack_1 /bin/bash
bash-4.3# ngrep -d eth0 -W byline
interface: eth0 (172.23.0.0/255.255.0.0)
####
T 172.23.0.1:32814 -> 172.23.0.2:4569 [AP]
POST / HTTP/1.1.
X-Amz-Target: DynamoDB_20120810.ListTables.
User-Agent: aws-sdk-dotnet-coreclr/3.3.10.3 aws-sdk-dotnet-core/3.3.24.3 .NET_Core/4.6.26628.05 OS/Darwin_17.7.0_Darwin_Kernel_Version_17.7.0:_Thu_Jun_21_22:53:14_PDT_2018;_root:xnu-4570.71.2~1/RELEASE_X86_64 ClientAsync.
Host: localhost:4569.
X-Amz-Date: 20180724T143438Z.
X-Amz-Content-SHA256: 44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a.
Authorization: AWS4-HMAC-SHA256 Credential=foobar/20180724/us-east-1/dynamodb/aws4_request, SignedHeaders=content-type;host;user-agent;x-amz-content-sha256;x-amz-date;x-amz-target, Signature=f50e1c32daa5525e415e8045a74da277f75c6930af2407681d3ec227b39be2f1.
Content-Length: 2.
Content-Type: application/x-amz-json-1.0.
.
{}
##
T 172.23.0.2:4569 -> 172.23.0.1:32814 [AP]
HTTP/1.1 200 OK.
```

ngrep will print the contents of all packets that are sent to and from the localstack process.

If you have any suggestions for improvements to the docs, or have a better tool
for monitoring network traffic, or anything else you think might be useful, feel
free to open an issue or submit a pull request.