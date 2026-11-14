FROM ubuntu:26.04

# Set labels for container metadata
LABEL maintainer="Michael VanLoon <michaelv9876@gmail.com>"
LABEL description="Lightweight C/C++ builder container with gcc-16, cmake, and testing frameworks"

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core build tools
    build-essential \
    gcc-16 \
    g++-16 \
    libstdc++-16-dev \
    make \
    cmake \
    \
    # GCC sanitizer shared runtimes (ASan/TSan/UBSan/LSan; MSan is LLVM-only)
    libasan8 \
    libtsan2 \
    libubsan1 \
    liblsan0 \
    \
    # Testing frameworks
    libgtest-dev \
    libgmock-dev \
    \
    # Additional utilities
    git \
    curl \
    wget \
    pkg-config \
    ca-certificates \
    \
    # Cleanup apt indexes and package caches in this layer
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/*

# Create symlinks for default gcc/g++ versions
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-16 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-16 100 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
