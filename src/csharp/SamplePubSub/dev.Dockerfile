FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5111 
EXPOSE 5111

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["SamplePubSub.csproj", "SamplePubSub/"]
RUN dotnet restore "SamplePubSub/SamplePubSub.csproj"
COPY . .
RUN dotnet publish "SamplePubSub.csproj" -c Build -o /app/publish /p:UseAppHost=false

FROM base AS final
# Install debug tools 
# https://github.com/vscode-kubernetes-tools/vscode-kubernetes-tools/blob/master/debug-on-kubernetes.md#6-dotnet-debugging
RUN apt update
RUN apt install -y wget unzip procps
RUN wget https://aka.ms/getvsdbgsh -O - 2>/dev/null | /bin/sh /dev/stdin -v latest -l ~/vsdbg

WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "SamplePubSub.dll"]