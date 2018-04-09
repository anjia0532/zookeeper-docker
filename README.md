zookeeper-docker
================

Useage
================

### clone repo

```bash
$ git clone https://github.com/anjia0532/zookeeper-docker.git
$ cd zookeeper-docker
```

### Build

```bash
$ docker build --build-arg ZK_VERSION=3.4.10 . -t anjia0532/zookeeper:stable-alpine
$ docker build . -t anjia0532/zookeeper:stable-alpine # default ZK_VERSION is 3.4.11
```

### set zk config
```bash
$ docker run  -d --name zk  -e ZK_abc_a=1 anjia0532/zookeeper:3.4.11-alpine && docker container exec zk cat /opt/zk/conf/zoo.cfg
# //output 
# //...
# //abc.a=1
```

### env

1. ZK_abc_a => abc.a
2. ZK_aBc => aBc
3. ZK_aB_c => aB.c

Thanks
================
1. [wurstmeister/zookeeper-docker](https://github.com/wurstmeister/zookeeper-docker)
2. [wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker)
3. [rawmind0/alpine-zk](https://github.com/rawmind0/alpine-zk)

Feedback
=====================
[create new issues](https://github.com/anjia0532/zookeeper-docker/issues/new)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2017-, by AnJia <anjia0532@gmail.com>.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
