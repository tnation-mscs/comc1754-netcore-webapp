FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 5000

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["comc1754-netcore-webapp.csproj", "./"]
RUN dotnet restore "./comc1754-netcore-webapp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "comc1754-netcore-webapp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "comc1754-netcore-webapp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "comc1754-netcore-webapp.dll"]
