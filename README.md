from  
https://testdriven.io/blog/testing-angular-with-cypress-and-docker/  
with my modifications  
* cypress.json: "modifyObstructiveCode": false,  
* last version:  
    + angular 8,
    + cypress 3.3.1,  
    + FROM node:10.16.0-jessie  
    + FROM nginx:stable  
    + FROM cypress/browsers  
* Dockerfile  
    + COPY --from=builder /usr/src/app/dist/try-angular-cypress /usr/share/nginx/html  
    + was COPY --from=builder /usr/src/app/dist /usr/share/nginx/html  



To run   
docker-compose up -d --build  
docker-compose run cypress ./node_modules/.bin/cypress run  

To stop  
docker-compose down  