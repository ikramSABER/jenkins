# -----------------------------
# Jenkins base image
# -----------------------------
FROM jenkins/jenkins:lts

USER root

# -----------------------------
# Update and install system dependencies safely
# -----------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    python3 \
    python3-venv \
    wget \
    curl \
    unzip \
    gnupg \
    ca-certificates \
    xvfb \
    git \
    default-jdk \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Create and activate virtual environment for Python
# -----------------------------
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# -----------------------------
# Install pip, Robot Framework, SeleniumLibrary in venv
# -----------------------------
RUN pip install --upgrade pip setuptools wheel
RUN pip install robotframework robotframework-seleniumlibrary

# -----------------------------
# Optional: set python alias
# -----------------------------
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# -----------------------------
# Add Google Chrome (for local testing if needed)
# -----------------------------
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install ChromeDriver (stable version, not tied to Chrome version)
# -----------------------------
RUN CHROMEDRIVER_VERSION=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE) \
    && wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod +x /usr/local/bin/chromedriver

# -----------------------------
# Switch back to Jenkins user
# -----------------------------
USER jenkins

WORKDIR /var/jenkins_home

EXPOSE 8080

CMD ["jenkins.sh"]
