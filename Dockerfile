FROM ubuntu:24.04

# Set labels for container metadata
LABEL maintainer="Michael VanLoon <michaelv9876@gmail.com>"
LABEL description="Lightweight C/C++ builder container with gcc-15, cmake, and testing frameworks"

# Update package lists and install development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core build tools
    build-essential \
    gcc-15 \
    g++-15 \
    make \
    cmake \
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
    # Cleanup
    && rm -rf /var/lib/apt/lists/*

# Create symlinks for default gcc/g++ versions
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-15 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-15 100 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
