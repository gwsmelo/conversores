echo
echo "      #########################################
      ##                                     ##
      ##   Conversores CD11 e REFTEK  v1.2   ##
      ##                                     ##
      ##         Guilherme de Melo           ##
      ##         gwsmelo@gmail.com           ##
      ##                                     ##
      #########################################" 
echo \  
echo
echo
echo "Digiite o nome da do seu usuario de computador:"
read usuario	

conversores () {

echo "Digite o número do formato inicial e em seguida a tecle ENTER:"
echo \	
echo "              1 -> CD11   2 -> REFTEK"
read formatoinicial
echo

if [ $formatoinicial -eq 1 ]; then
	echo "Digite a sigla da rede sismografica e aperte ENTER. EX: NB -> RSISNE"
	read sigladarede	
	echo
	echo "Digite o número do formato final:"
	echo
	echo "         1 -> MSEED   2 -> SAC   3 -> SEISAN   "
	echo
	read formatofinal1
		if [ $formatofinal1 -eq 1 ]; then	
			for cd11final1 in `ls ./.Conversores/CD11/2*******/*.cd11` #Lendo arquivos .cd11 do SMART24Reader
			do
			wine ./.Conversores/.smart24.exe $cd11final1
			mv /home/$usuario/.Conversores/CD11/2*******/*msed /home/$usuario/.Conversores/MSEED
			done
					
			cd /home/$usuario/.Conversores/MSEED
			echo 				
			echo "Mudando nome da rede para LS:"
			echo 
			
			for net in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader
			do
			cp $net netTemp
				msmod --net $sigladarede netTemp -o $net
			rm netTemp 	
			done
			
			echo			
			echo "Separando o mseed para cada componente:"
			for msedHHZ in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Vertical
			do
				cp $msedHHZ temp
				/home/$usuario/.Conversores/.wavetool1.expect
				rm temp	
				done
			for msedHH1 in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Norte-Sul
		        do
				cp $msedHH1 temp
				/home/$usuario/.Conversores/.wavetool2.expect
  				rm temp			
			done
			for msedHH2 in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Leste-Oeste
  			do
				cp $msedHH2 temp
				/home/$usuario/.Conversores/.wavetool3.expect
  				rm temp	
			done	

			#Apagando temporarios
			rm extract*
			rm resp*
			rm *.msed > /dev/null

			echo "Renomeando para o formato do SC3"
			
	  		cat /home/$usuario/.Conversores/MSEED/*HH* | seiscomp exec scart ./SDS/
			cd  /home/$usuario/.Conversores/MSEED/
			rm *HH*

			
		fi > /dev/null

	        
		if [ $formatofinal1 -eq 2 ]; then	
			for cd11final2 in `ls ./.Conversores/CD11/2*******/*.cd11` #Lendo arquivos .cd11 do SMART24Reader
			do
			wine ./.Conversores/.smart24.exe $cd11final2
			mv ./.Conversores/CD11/2*******/*msed /home/$usuario/.Conversores/SAC
			done
			cd ./.Conversores/SAC
			
			echo 				
			echo "Mudando nome da rede para LS:"
			echo 
			
			for net in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader
			do
			cp $net netTemp
				msmod --net $sigladarede netTemp -o $net
			rm netTemp 	
			done
			
			echo			
			echo "Separando o mseed para cada componente:"
			for msedHHZ in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Vertical
			do
				cp $msedHHZ temp
				/home/$usuario/.Conversores/.wavetool1.expect
				rm temp	
				done
			for msedHH1 in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Norte-Sul
		        do
				cp $msedHH1 temp
				/home/$usuario/.Conversores/.wavetool2.expect
  				rm temp			
			done
			for msedHH2 in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Leste-Oeste
  			do
				cp $msedHH2 temp
				/home/$usuario/.Conversores/.wavetool3.expect
  				rm temp	
			done	

			#Apagando temporarios
			rm extract*
			rm resp*
			rm *.msed > /dev/null
			
			for mseedtosac in `ls 20***************************H***` #Lendo arquivos MSEED e convertendo para SAC
		        do
				mseed2sac $mseedtosac
			    #rm $mseedtosac			
			done 
		fi > /dev/null

		

		if [ $formatofinal1 -eq 3 ]; then	
			for cd11final3 in `ls ./.Conversores/CD11/2*******/*.cd11` #Lendo arquivos .cd11 do SMART24Reader
			do
			wine ./.Conversores/.smart24.exe $cd11final3
			mv ./.Conversores/CD11/2*******/*msed /home/$usuario/.Conversores/SEISAN/
			done
			cd ./.Conversores/SEISAN
			
			echo 				
			echo "Mudando nome da rede para LS:"
			echo 
			
			for net in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader
			do
			cp $net netTemp
				msmod --net $sigladarede netTemp -o $net
			rm netTemp 	
			done
			
			echo			
			echo "Separando o mseed para cada componente:"
			for msedHHZ in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Vertical
			do
				cp $msedHHZ temp
				/home/$usuario/.Conversores/.wavetool1.expect
				rm temp	
				done
			for msedHH1 in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Norte-Sul
		        do
				cp $msedHH1 temp
				/home/$usuario/.Conversores/.wavetool2.expect
  				rm temp			
			done
			for msedHH2 in `ls *.msed` #Lendo arquivos MSEED do SMART24Reader do componente Leste-Oeste
  			do
				cp $msedHH2 temp
				/home/$usuario/.Conversores/.wavetool3.expect
  				rm temp	
			done	

			#Apagando temporarios
			rm extract*
			rm resp*
			rm *.msed > /dev/null
			
			for mseedtoseisan in `ls 20***************************H***` #Lendo arquivos MSEED e convertendo para SAC
		        do
				cp $mseedtoseisan temp
				/home/$usuario/.Conversores/.wavetool4.expect
				rm temp	
				rm $mseedtoseisan
				rm *.mes
				rm *.out	
			done
		fi > /dev/null 
		
fi



if [ $formatoinicial -eq 2 ]; then
	echo	
	echo "Digite a sigla da rede sismografica e aperte ENTER. EX: NB -> RSISNE"
	read sigladarede	
	echo
	echo "Digite o número do formato final:"
	echo
	echo "         1 -> MSEED   2 -> SAC   3 -> SEISAN   "
	echo
	read formatofinal2
		if [ $formatofinal2 -eq 1 ]; then
			cd ./.Conversores/.REFtoMSEED
			gedit rtu.ini
			for refFILE in `ls /home/$usuario/.Conversores/REFTEK/2******/****/1/*_*` #Lendo arquivos REFTEK 
				do > /dev/null
				rtseis $refFILE
								
				for seisFILE in `ls *.sei` #Lendo arquivos SEISAN
				do

				cp $seisFILE temp
		
				/home/$usuario/.Conversores/.REFtoMSEED/wavetool.expect

				rm temp	
				rm extr*
				rm resp*
				rm *.sei
				done
				done
				
			for net in `ls *__*` #Lendo arquivos MSEED 
			do
			cp $net netTemp
				msmod --net $sigladarede netTemp -o $net
			rm netTemp 	
			done
			
			mv *__* /home/$usuario/.Conversores/MSEED
						
			cd ../
			cd  ./MSEED/
			cat /home/$usuario/.Conversores/MSEED/*__* | seiscomp exec scart ./SDS/
			rm *__*
		fi  > /dev/null

		if [ $formatofinal2 -eq 2 ]; then 
		cd ./.Conversores/.REFtoSAC		
		gedit rtu.ini
			for refFILE in `ls /home/$usuario/.Conversores/REFTEK/2******/****/1/*_*` #Lendo arquivos REFTEK
				do
				rtseis $refFILE
								
				for seisFILE in `ls *.sei` #Lendo arquivos SEISAN
				do

				cp $seisFILE temp

				/home/$usuario/.Conversores/.REFtoSAC/wavetool.expect

				rm temp	
				mv *SAC /home/$usuario/.Conversores/SAC
				rm extr*
				rm resp*
				rm *.sei
				done
			done
		
		fi > /dev/null
		
		

		if [ $formatofinal2 -eq 3 ]; then 
		cd ./.Conversores/.REFtoSEISAN		
		gedit rtu.ini
			for files in `ls /home/$usuario/.Conversores/REFTEK/2******/****/1/*_*` #entrada dos dados.
				do
				rtseis $files
	
				
				mv *.sei /home/$usuario/.Conversores/SEISAN
			done
		fi > /dev/null
		
		echo
		echo "Convertendo..."
		
		
fi

echo
echo "Conversão concluída!"
echo 
}
