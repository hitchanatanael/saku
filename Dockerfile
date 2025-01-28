# Gunakan image Debian sebagai base untuk setup manual
FROM debian:bullseye-slim

# Update sistem dan instal dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip git libgl1-mesa-glx libpulse0 xz-utils \
    && apt-get clean

# Download Flutter SDK
ENV FLUTTER_VERSION=3.27.1
RUN curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter.tar.xz \
    && rm flutter.tar.xz \
    && mv flutter /usr/local/flutter

# Tambahkan Flutter ke PATH
ENV PATH="/usr/local/flutter/bin:$PATH"

# Pre-download dependencies
RUN flutter precache

# Cek versi Flutter dan Dart
RUN flutter doctor -v

# Set direktori kerja
WORKDIR /app

# Salin semua file proyek
COPY . .

# Unduh dependencies proyek
RUN flutter pub get

# Default command untuk container
CMD ["flutter", "run", "--no-sound-null-safety"]
