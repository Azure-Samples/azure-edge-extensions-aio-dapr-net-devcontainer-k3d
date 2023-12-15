FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5111 
EXPOSE 5111

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["SamplePubSub.csproj", "SamplePubSub/"]
RUN dotnet restore "SamplePubSub/SamplePubSub.csproj"
COPY . .

FROM build AS publish
RUN dotnet publish "SamplePubSub.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SamplePubSub.dll"]