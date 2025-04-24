# ==========================
# Base image
# ==========================
FROM mcr.microsoft.com/dotnet/runtime:9.0-alpine AS base
WORKDIR /app

# ==========================
# Build Stage
# ==========================
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

COPY . .
RUN dotnet restore App
RUN dotnet publish "./App/App.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# ==========================
# Run Stage
# ==========================
FROM base AS run
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "App.dll"]