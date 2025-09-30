# Audio Delay Script

Este repositório contém um script em **Windows Batch** para **adicionar segundos de áudio mudo no final** de arquivos: `.sln` `.sln16` `.gsm` `.wav`

Muito útil para modificar áudios do **Asterisk**.

### Como funciona:
O script pede a **quantidade de segundos** desejada e uma **pasta com arquivos** para modificar.

Ao especificar a pasta de entrada, ele **itera por todos os arquivos da pasta e suas subpastas** modificando cada um. Ao terminar é **gerada uma nova pasta _new com os arquivos modificados e uma pasta _wav com todos os arquivos em .wav** para ser melhor de ouvir e testar.

### Pré-requisitos:
Ter instalado o programa **[SoX](http://sox.sourceforge.net/)** e adicionar ele ao **PATH** do sistema. 

> Sem o SoX instalado, o script **não funciona**.

### Como usar:
1. Baixe o script em uma pasta do seu computador.  
2. Na mesma pasta, coloque sua **pasta de arquivos de áudio** que quer modificar.  
3. Abra o **CMD** nessa pasta com o script e a pasta de arquivos de áudio. 
4. Rode o script fornecendo a quantidade de segundos (ex: 1 ou 2.5) e o nome da pasta de entrada.

```bat
delay_audio_files.bat
