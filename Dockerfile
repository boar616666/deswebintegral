FROM node:18

WORKDIR /app
COPY . .

RUN mkdir -p output && echo "<h1>Hola desde Docker</h1>" > output/index.html

CMD ["cp", "-r", "output", "/output"]
