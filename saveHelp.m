  function saveHelp(raman)
            
            name = strcat('Saved_Spectras/' ,raman.file_default, '.txt');
            
            raman.saving = raman.saving-1;
            raman.num_Saved = raman.num_Saved + 1;
            
            raman.saved_Spectra = [raman.saved_Spectra transpose(raman.spectrum)];

            time = datetime('now');
            stamp = datestr(time);
            newName = strcat(raman.custom_Name, stamp, '~');
            
            raman.spectra_Names = [raman.spectra_Names, newName];
            
            names = raman.spectra_Names;
            data = raman.saved_Spectra;
            
            sav = num2str(raman.num_Saved);
            scan = num2str(length(data(:,1)));
            temp = strcat(sav, '/', scan, '\n');
            header = sprintf(temp);
            
            fileID = fopen(name, 'wt');
            fprintf(fileID, header);
            fprintf(fileID, '%s', names);
            fclose(fileID);
            
            dlmwrite(name, data, '-append', 'delimiter', ' ')
            
            raman.saved_Waves = [raman.saved_Waves transpose(raman.wavelengths)];
                        
            dlmwrite(name, raman.saved_Waves, '-append', 'delimiter', ' ')

            
            x = num2str(raman.xDim);
            y = num2str(raman.yDim);
            temp = strcat(x, '/', y, '\n');
            footer = sprintf(temp);
            
            fileID = fopen(name, 'a');
            fprintf(fileID, footer);
            fclose(fileID);
        end
