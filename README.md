# isa-must-gather : 
<details>
<summary>한국어</summary>

must-gather는 openshift cluster 및 위에 배포된 MAS Application 로그를 추출할수 있는 client tool 입니다.

Openshift must-gather : https://docs.openshift.com/container-platform/4.10/support/gathering-cluster-data.html#gathering-data-specific-features_gathering-cluster-data

IBM MAS must-gather : https://www.ibm.com/support/pages/node/6487991

## 용도
문제 발생시, MUST-GATHER를 이용해서 openshift 및 MAS 관련 로그를 추출하는 troubleshooting 용도 사용됩니다.
log 추출을 위해서 위 링크에 명시된 명령어를 찾아서 입력해야하나, 이런 불편함을 감소하기 위해서 isa-must-gather라는 tool을 만들었다.

## 사용방법
[1] script를 받아서 서버에 설치한다.

[1.1] Git clone 하기
```
#원하는 directory로 이동후, 
git clone https://github.com/isaaclee1001/isa-must-gather.git
```
[1.2] Release에서 다운로드하기

[2]실행하기
shell sciprt 받은 directory = must-gather  LOG 다운받는 directory

```
sh isa-must-gather.sh
```
log 추출을 기다린다.

[3] Option 설명

```
MAS COMPONENTS:

1. MAS application  <--- MAS 전체 관련 로그 추출
2. MAS Core         <--- CORE 관련 로그만 추출
3. MAS Manage
4. MAS Health
5. Exit
- - - - - - - - - - - - - -
Which MAS component log do you need? ( 1 ~ 5 ):  1
Please Input MAS Instance ID: inst      <------ MAS Instance명 입력 : 현재 설치 instance 명 = inst
Include Openshift Cluster logs (Y/N)? Y   <------ openshift log 필요시 : yes
```
💡 현재 어는 부분이 문제 일지 모를 경우 -> Openshift 전체, MAS 전체 로그 추출, option은 아래와 같다
1. MAS Application
2. MAS instance ID : inst 
3. Openshift clust log : yes

## 미작동시..
 위 Shell script미작동시,
1. 원하는 directory 진입
2. 아래 명령어 실행
```
oc adm must-gather --dest-dir=./$FILE_PREFIX$(date "+%Y%m%d") --image-stream=openshift/must-gather --image=quay.io/aiasupport/must-gather -- gather -cgl --mas-instance-id inst
```
-> 아래 명령어는 OPENSHIFT cluster & MAS application 전체 log를 추출하는 명령어이다. openshift & MAS 관련 모든 log를 추출하는 관계로 시간이 소요된다.
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
