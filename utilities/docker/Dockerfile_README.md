# Nmap, nmap scripts, vulnscan

## Abstract
Comes fully equipped with
the latest Nmap Scripting Engine (NSE) modules, as well as the [Vulnscan](https://github.com/khulnasoft-lab/vulnscan) NSE script.  
The databases used by Vulnscan are pulled using the original updater script when image is built  
  
## Source

https://github.com/khulnasoft-lab/vulnscan

## Usage

```bash
docker build -t vulnscan .
docker run -it vulnscan:latest
```

## Help:

```bash
docker run -it nmap -sV --script=vulnscan/vulnscan.nse www.example.com
```

## Demo  
[![asciicast](https://asciinema.org/a/141837.png)](https://asciinema.org/a/141837)
