# FIX DOCKER WORDPRESS WITH SSL
RUN DOCKER local port in 443 for use SSL LIKE THIS :
```
docker run --name wp -p 83:443 -d mubar3/wordpress
```

# IF USING TUNNEL CLOUDFLARE
-service type using https

-in additional setting -> tls -> no tls verify is enable