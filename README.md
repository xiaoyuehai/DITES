# *DITES: A Dual Core TEE SoC Based on RISC-V*
# *(Please note that this is the initial version (V1.0) and we will gradually update the introduction of each document.)*
## **Contact information:Yuehai Chen (reshaker@163.com)**
> *Copyright (C) 2021-2022, Guangdong University of Technology, Guangzhou*

> *Digital HDL source code of DITES is free: you can redistribute it and/or modify it under the terms of the Solderpad Hardware License v2.0, which extends the Apache v2.0 license for hardware use.*

> *The software, hardware and materials distributed under this license are provided in the hope that it will be useful on an **'as is' basis, without warranties or conditions of any kind, either expressed or implied; without even the implied warranty of merchantability or fitness for a particular purpose**. See the Solderpad Hardware License for more details.*

> *You should have received a copy of the Solderpad Hardware License along with the DITES HDL files (see [LICENSE](LICENSE) file). If not, see <https://solderpad.org/licenses/SHL-2.0/>.*

DITES is a **dual-core** TEE SoC based on a Reduced Instruction Set Computer-V (RISC-V). The key features of our DITES are as follows.

**(a)** a **fully isolated multi-level** bus architecture based on a lightweight RISC-V processor with an integrated **crypto core** supporting Secure Hashing Algorithm-1 (SHA1), Advanced Encryption Standard (AES), and Rivest–Shamir–Adleman (RSA), among which RSA can be configured to five key lengths (192, 256, 512, 1024, and 2048 bits). 

**(b)** Based on Chain-of-Trust (CoT), we design a **secure boot** process that combines SHA1 extraction program digest and RSA signature verification. Meanwhile, **Input/Output Physical Memory Protection (IOPMP)** has been designed as a firewall to restrict access to the CPU and the crypto core. 

**(c)** a **hierarchical access strategy** is proposed for data exchange to ensure secure inter-core communication.

In case you decide to use the DITES HDL source code for academic or commercial use, we would appreciate if you let us know; **feedback is welcome**. Upon usage of the source code, please cite the associated paper (also available [here](https://doi.org/10.3390/s22165981)): 

> Chen, Y.; Chen, H.; Chen, S.; Han, C.; Ye, W.; Liu, Y.; Zhou, H. DITES: A Lightweight and Flexible Dual-Core Isolated Trusted Execution SoC Based on RISC-V. Sensors 2022, 22, 5981.

If you would like to learn about the open source processor for this project, please visit the T-head-Semi home page under opene902 (also available [here](https://github.com/T-head-Semi/opene902)).
