# Use a imagem oficial do Alpine do Go como base para complilação
FROM golang:1.21-alpine as builder

# Configuração do diretório de trabalho
WORKDIR /usr/src/app

# Adiciona um arquivo go.mod vazio
RUN go mod init placeholder

# Copie o código fonte para o diretório de trabalho
COPY main.go .

# Compilação do código Go e desativa a criação de debug information
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o main .

# Imagem de produção mais leve
FROM scratch

# Configuração do diretório de trabalho
WORKDIR /usr/src/app

# Copie o binário compilado da etapa anterior para este estágio
COPY --from=builder /usr/src/app/main .

# Comando a ser executado ao iniciar o contêiner
CMD ["./main"]