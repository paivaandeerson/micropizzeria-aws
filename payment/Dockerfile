# Use uma imagem base oficial do Node.js
FROM node:16

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o package.json e o package-lock.json para o diretório de trabalho
COPY package*.json ./

# Instale as dependências da aplicação
RUN npm install

# Copie o restante do código da aplicação para o diretório de trabalho
COPY . .

# Compile o código TypeScript
RUN npm run build

# Exponha a porta na qual a aplicação será executada
EXPOSE 3000

# Defina o comando para iniciar a aplicação
CMD ["npm", "start"]
