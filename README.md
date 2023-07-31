# isa-must-gather : 
<details>
<summary>한국어</summary>
isa-must-gather는 
must-gather는 현 openshift cluster 정보를 추출하는 client tool이다. 
Opeshift위에 배포된 MAS application 상태도 추출 가능하다.
Openshift와 MAS 라는 미지의 세계를 경험하다보면 수많은 문제와 질문에 봉착하게 된다. 그럴때마다, must-gather 명령어를 찾아서 입력하는 과정이 불편함을 isa-must-gather라는 tool을 만들었다.

TO-DO 
isa-must-gather는 현재 MAS component 중심적으로 설계되었다. 추후, Openshift에 대한 상세 component를 명시할수 있도록 기능을 추가할 계획이다.


</details>

<details>
<summary> English </summary>

## Aim
After running countless number of times must-gather commands, I must have all of the must-gather commands at the back of my mind. But, it never sticks arounds and I have to constantly refer to Redhat  or IBM MAS documentation for the must-gather command.

isa-must-gather is a friendly cli tool that receives inputs and run Openshift's must-gather command accordingly. No more pains of referring to the Redhat or IBM documentations.

Most importantly, the initial version is focused towards collecting MAS data.

## Who should use it?
If you are MAS admin, developer , devops that need to run must-gather commands.

## How to install
Not much of installation.
Simpl,
1. download the shell script
2. copy the script to cluster

## How To Run
### Method 1: simply run the script
Go to destination directory, and run the script.
```
sh isa-must-gather.sh
```
(-) Cannot run this script anywhere
This method is not flexible. You need to remember the location of the script

### Method 2: Create Symbolic Link
2.1. Create Symbolic Link
````
sudo ln -s /path/to/run_must_gather.sh /usr/local/bin/runMustGather
````
With above method, 
2.2. 
```

```

</details>

## Reference 
Openshift must-gather : https://docs.openshift.com/container-platform/4.10/support/gathering-cluster-data.html#gathering-data-specific-features_gathering-cluster-data

IBM MAS must-gather : https://www.ibm.com/support/pages/node/6487991
