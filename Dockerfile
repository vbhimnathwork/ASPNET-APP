FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore src/Components/benchmarkapps/BlazingPizza.Server/BlazingPizza.Server.csproj
RUN dotnet publish src/Components/benchmarkapps/BlazingPizza.Server/BlazingPizza.Server.csproj -c Release -o /app/publish
FROM mcr.microsoft.com/dotnet/aspnet:9.0-jammy-chiseled
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet","BlazingPizza.Server.dll"]