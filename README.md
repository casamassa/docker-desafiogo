# docker-desafiogo

Conforme solicitado no Desafio Go:

1. Para rodar basta executar
   docker run casamassa/fullcycle

   Para isso, criei o Dockerfile e executei o comando de build para gerar a imagem:
   docker build -t casamassa/fullcycle .
   Em seguida executei o comando para fazer o push para minha conta no DockerHub:
   docker push casamassa/fullcycle

2. A imagem ficou com 1,17MB, abaixo do 2MB. Para atender esse requisito no Dockerfile, tive que:
   - Usar a imagem base golang:1.21-alpine que é mais leve que golang:1.21
   - Compilar o código Go desativando a criação de debug information
   - Usar como imagem base final "FROM scratch". Essa é a imagem mais mínima possível, pois não contém nada além do binário e suas dependências diretas. Entretanto, isso significa que precisa ter certeza de que não há dependências externas necessárias durante a execução do aplicativo, o que era o caso.

Obs. Optei por não instalar o Go no meu computador, queria fazer o desafio usando apenas o Docker e o VsCode. Por não ter o Go instalado e precisar rodar um teste do meu código Go, optei por rodar um container temporário, criando um volume para que o container usa-se o arquivo main.go do meu diretorio e executando um comando shell no container para rodar o código:
Este foi o comando usado durante o desenvlvimento:
docker run --rm -v $PWD:/app golang sh -c "go run /app/main.go"
Por não ter experiência alguma com Go, esse artigo me ajudou com isso:
https://blog.giovannidemizio.eu/2021/05/17/how-to-go-run-without-go-with-docker/
