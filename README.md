# My docker VM template

## Usage

### Config ssh key

```bash
echo key.pub >> ./data/.ssh/authorize.key
```

### Build image

default user name is `cyan`
```bash
docker build -t my-vm .

# or use under command to change username
docker buld -t my-vm . --build-arg user=username
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
