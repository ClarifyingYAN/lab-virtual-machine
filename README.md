# My docker VM template

## Usage

### Config ssh key

```bash
echo key.pub >> ./data/.ssh/authorize.key
```

### Build image

+ default root password is `123456`
+ default user name is `cyan`

```bash
docker build -t my-vm .

# or use under command to set other value
docker build \
 --build-arg user=username \
 --build-arg root_passwd=password \
 -t my-vm .
```

### Run container

```bash
docker run -d \
    -p 8080:80 \
    -p 8443:443 \
    -p 8022:22 \
    -p 10000:10000 \
    -p 10001:10001 \
    -v "/$(pwd)/data/.ssh:/home/[username]/.ssh" \
    --name myVM my-vm
```

> Notes:
> 
> May face unknown host problem, try delete record in `~/.ssh/known_hosts`

## Tools

+ Golang
+ Conda
