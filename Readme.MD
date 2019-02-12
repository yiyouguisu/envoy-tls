## 初始化CA证书

```shell
cfssl gencert -initca ca/ca-csr.json | cfssljson -bare ca
```

## 创建 TLS 证书 和 私有密钥

```shell
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca/ca-config.json \
  -profile=default \
  ca/consul-csr.json | cfssljson -bare consul
```

## TEST
```shell
curl -v --cert service.pem --key service-key.pem --cacert ca.pem https://www.service.com:8443/service/1


*   Trying 172.16.186.135...
* TCP_NODELAY set
* Connected to www.service.com (172.16.186.135) port 8443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
* successfully set certificate verify locations:
*   CAfile: ca.pem
  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Request CERT (13):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Certificate (11):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS handshake, CERT verify (15):
* TLSv1.2 (OUT), TLS change cipher, Client hello (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
* ALPN, server did not agree to a protocol
* Server certificate:
*  subject: C=CN; ST=SH; L=SH; O=Envoy TLS Test; OU=CA
*  start date: Jan 23 11:27:00 2019 GMT
*  expire date: Jan 23 11:27:00 2020 GMT
*  subjectAltName: host "www.service.com" matched cert's "www.service.com"
*  issuer: C=CN; ST=SH; L=SH; O=Envoy TLS Test; OU=CA; CN=service.com
*  SSL certificate verify ok.
> GET /service/1 HTTP/1.1
> Host: www.service.com:8443
> User-Agent: curl/7.54.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< content-type: text/html; charset=utf-8
< content-length: 89
< server: envoy
< date: Thu, 24 Jan 2019 02:54:32 GMT
< x-envoy-upstream-service-time: 7
< 
Hello from behind Envoy (service 1)! hostname: a1bbad959abb resolvedhostname: 172.18.0.4
* Connection #0 to host www.service.com left intact
```