FROM mcr.microsoft.com/dotnet/aspnet:7.0

RUN mkdir /app
WORKDIR /app

COPY ./v1/webapp/bin/Release/netcoreapp7.0/publish ./

EXPOSE 80
ENTRYPOINT ["dotnet", "webapp.dll"]