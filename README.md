# Test Drive - Red Hat OpenShift Container Platform 4
SMT SAT GAQ12023V1

# Instruções:


## Pré-requisitos
   
#### Crie um fork do repositório a seguir com sua conta GitHub: (https://github.com/system-manager-br/openshift-test-drive)
1. Acesse https://github.com com a sua conta pessoal, ou crie um conta:

![image](https://user-images.githubusercontent.com/41959558/205717011-e1eff073-740d-4831-bbab-b571ee577e16.png)


2. Acesse https://github.com/system-manager-br/openshift-test-drive e crie um "fork":

![image](https://user-images.githubusercontent.com/41959558/205716393-9554ce59-d85a-440b-93b4-678e98277b35.png)



Obs.: Anote a URL gerada após o fork.
   
#### Aguarde o envio da URL e conta de acesso ao OpenShift.

### 1 - Acessando o ambiente
1. Acesso via Web Console - Insira suas credenciais:

![image](https://user-images.githubusercontent.com/41959558/205715775-e4e20668-f877-49ab-b44b-aedec6977ae3.png)



### 2 - Explorando o ambiente com o instrutor:

(O instrutor irá apresentar os itens abaixo)

   - Console
   - Perfil admin
   - Perfil dev

### 3 - Explorando o ambiente via CLI:

![image](https://user-images.githubusercontent.com/41959558/205774329-9ed9f7cf-41f9-4e9c-a313-4e748ce9429f.png)



Execute os comandos utilizando o client "oc" ou "kubectl":
 
      $ oc project
      $ oc projects
      $ oc get pods
      $ oc get nodes

## 4- Deploy de aplicação com OpenShift Pipelines:

O Red Hat OpenShift Pipelines é uma solução de integração e entrega contínua (CI/CD) nativa da nuvem para criar pipelines usando Tekton. Tekton é uma estrutura flexível de CI/CD de código aberto nativa do Kubernetes, que permite automatizar implantações.

1. Altere para o perfil de desenvolvedor

![image](https://user-images.githubusercontent.com/41959558/205756188-d82efce0-2575-4f3e-a2a0-cb89596bfc02.png)

2. Selecione o menu +Add;

![image](https://user-images.githubusercontent.com/41959558/205756314-7895c0f2-ea36-4e69-9551-3a4b3df2ccac.png)


3. Valide que o projeto (namespace), que possui o mesmo nome da sua conta de acesso, está selecionado ao lado direito do perfil de desenvolvedor;

![image](https://user-images.githubusercontent.com/41959558/205756715-63438717-3808-4344-9bfa-1f609ff5c87e.png)


4. Clicar em "**Git Repository - Import from Git**";

![image](https://user-images.githubusercontent.com/41959558/205756860-ef89dbdb-6191-4350-b993-c3ff8889a5fa.png)


5. Preencha os dados solicitados:
      - No campo **Git Repo URL:** insira a url gerada ao realizar o fork na etapa de pré-requisitos;

![image](https://user-images.githubusercontent.com/41959558/205757428-1fe9d9b6-bad0-4df4-ba9f-f4cf391ca9a5.png)

 - Nos campos **Appplication name** e **Name**, altere os valores para: app<número do seu projeto)> (ex: usuário redhat40 -> app40)
 - Marcar o checkbox **Add pipeline**;
 - Desmarcar o checkbox **Create a route to the Application**;
 - Cilcar em **Resource limits**;

![image](https://user-images.githubusercontent.com/41959558/205759024-694fe90b-6eb7-4483-8e58-df97f9339046.png)


 - Preencha com os seguintes valores para os limites de recursos computacionais:
    - CPU
      - Request = 20 milicores;
      - Limit = 50 milicores;
    - Memory
      - Request = 70 Mi;
      - Limit = 150 Mi;
  - Clique no botão "Create";
   Aguarde o processo de construção (build) e escalação da aplicação (0 para 1). 
   Acompanhe os logs da execução em: **Pipelines > app<número do seu projeto>** > PipelineRuns > app<número do seu projeto>-xyz > Logs**;
      - Clique em **Topology** ;
      - Clique em cima do circulo azul da sua aplicação **app<número do seu projeto>**;
      - Explore as opções apresentadas (Details, Resources, Observe);
      
![image](https://user-images.githubusercontent.com/41959558/205760569-cf1d7b65-e849-474f-bee4-0380196d3425.png)

           
## 5 - Crie uma rota HTTP para a aplicação:
1. Clique em **Project** no canto esquerdo do console;
2. Clique em **Route** > **Create Route**, e preencha conforme abaixo:

![image](https://user-images.githubusercontent.com/41959558/205761210-87133612-36f2-46d5-ac19-9b9508075d1e.png)

  - **Name**: http-app<número do seu projeto>
  - **Hostname**: app<número do seu projeto>.(dominio-wildcard-do-cluster-openshift)
 
Exemplo:
![image](https://user-images.githubusercontent.com/41959558/205762439-0cdd9349-a57b-46c8-92c2-c49aec775a80.png)
   
   
  - **Service**: app<número do seu projeto>
  - **Target port**: 8080 -> 8080 (TCP)
  - Clicar em **Create**;
  - Acesse a rota em seu navegador;
  - Anote a rota em um bloco de notas;

## 6 - Crie uma rota HTTPS para a aplicação:
1. Clique em **Project** no canto esquerdo do console;
2. Clique em **Route** > **Create Route**, e preencha conforme abaixo:
      - **Name**: https-app<número do seu projeto>
      - **Hostname**: secure-app<número do seu projeto>.(dominio-wildcard-do-cluster-openshift)
      - **Service**: app<número do seu projeto>
      - **Target port**: 8080 -> 8080 (TCP)
      - Marque o checkbox **Secure Route**;
      - **TLS termination**: Edge
      - **Insecure traffic**: Redirect
      - Clicar em **Create**;
      - Acesse a rota em seu navegador;
      - Tente acessar a rota recém criada como HTTP e veja o comportamento do "Redirect";
      - Anote a rota em um bloco de notas;
      - Envie ambas as rotas (HTTP e HTTPS) no chat.

## 7 - Adicionar GitHub Webhook no Pipeline:

1. Clique em **Topology** no menu lateral, e abra a URL do POD chamado "Triggers", conforme abaixo:

![image](https://user-images.githubusercontent.com/41959558/205767228-9866e198-1500-4043-b56d-1c7ae2a42696.png)

2. Copie a URL;
3. Acesse seu repositório (repoistório clonado anteriormente), e clique nas seguintes opções: Settings -> Webhooks -> Add webhook:

![image](https://user-images.githubusercontent.com/41959558/205768124-10b03b31-b719-45ea-ac1f-185d074b56e0.png)

4. No formulario que aparecerá insira a URL do Trigger no campo "Payload URL", e em "Content type" selecione a opção "aplication/json", depois clique no botão "Add webhook";

![image](https://user-images.githubusercontent.com/41959558/205768386-fab11366-4942-416b-ab06-34e9eb80f3f0.png)


## 8 - Teste de Trigger com o GitHub Webhook:

Acesse seu GitHub e abra o repositório clonado para executar as tarefas abaixo.

1. Alterar o arquivo "/views/main.erb" na **linha 26**. No lugar de "Cliente", insira seu nome. (não remova nada antes ou depois da linha 26)

![image](https://user-images.githubusercontent.com/41959558/205769326-86686cb7-c7e8-48d1-bc75-aaef78f7446d.png)

2. Após essa alteração clique no botão "commit changes";

3. No console do OCP, voce pode acompahar a Pipeline iniciando um novo build e deploy da nova versão da Aplicação;

![image](https://user-images.githubusercontent.com/41959558/205770084-2545a395-4398-4bc9-8833-0d1498cb9473.png)
      
## 12 - Acessando os logs da aplicação

1. Acessar no menu lateral a opção "Topology", clique no icone do POD da aplicação e na sessão "Resources" clique "View logs":

![image](https://user-images.githubusercontent.com/41959558/205771089-142da8a4-6758-4264-8256-b4779ea715c7.png)

2. Faça algumas requisições na URL (atualize a página) e veja os logs.

## 9 - Escale a aplicação para 02 réplicas:
1. Clique em **Topology**;
2. Clique em cima do circulo azul da sua aplicação **app<número do seu projeto>**;
3. Clique em **Details** > botão de "Increase"

![image](https://user-images.githubusercontent.com/41959558/205763842-fab90fc8-a9c6-4701-8807-31a070f43256.png)

4. Acione o "Descrease" para 01 réplica.

![image](https://user-images.githubusercontent.com/41959558/205765160-d1cac259-9548-4a49-baf2-d9cf21e673d2.png)


## 10 - Autoscale da aplicação:

1. Acessar no menu lateral a opção "Topology", clique no icone do POD da aplicação e na sessão "Actions" clique na opcão "Add HorizontalPodAutoscaler":

![image](https://user-images.githubusercontent.com/41959558/205770597-85604833-6521-4c8d-9967-7bc6187ab078.png)

2. Será aberto um formulario para preenchimento dos parâmetros. Insira os valores, conforme o exemplo abaixo, e clique no botão "Save".

![image](https://user-images.githubusercontent.com/41959558/205770873-d2df1db0-4669-4852-ac7f-88dcee10c130.png)


## 11 - Teste de carga usando Apache Benchmark:

1. No menu lateral clique em "+Add" e em "All services":

![image](https://user-images.githubusercontent.com/41959558/205771608-03d19397-9dd5-4d88-a22d-91b3ee74c783.png)

2. Procure por por "httpd" e clique na primeira opção, depois em "Instantiate Template":

![image](https://user-images.githubusercontent.com/41959558/205771836-3628fc5e-889b-4e45-a598-5e23e17b801c.png)

3. Mude o nome para "apache-benchmark" e clique em "create":

![image](https://user-images.githubusercontent.com/41959558/205772242-127623e6-b7ef-44b7-b393-9d3367c738ff.png)

4. Acesse o seu projeto (namespace) via Web Terminal, e entre no terminal do Apache Benchmark. Em seguida execute o comando para disparar a carga na URL da aplicação e observe novas instâncias sendo criadas para atender a carga.

![image](https://user-images.githubusercontent.com/41959558/205773629-75518b04-db6c-4197-b06f-3d70a6cd7769.png)

# Obrigado pela participação!
