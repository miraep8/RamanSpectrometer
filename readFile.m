        function [xAxis, yAxis, xDim, yDim, names] = readFile(myFile)
            
           fileID = fopen(myFile);
           param = textscan(fileID, '%d', 2, 'Delimiter', '/');
           data = param{1, 1};
           
           sav = data(1);
           scan = data(2);
           disp(data)
           
           titles = textscan(fileID, '%s', sav, 'Delimiter', '~');
           names = char(titles{1,1});
           
           textscan(fileID, '%[~]', 1);
           
           for k = 1:scan
               
                   data = textscan(fileID, '%f', sav, 'Delimiter', ' ');
                   next = data{1, 1};
                   spectras = [spectras next];   
           end
            for k = 1:scan
                   data = textscan(fileID, '%f', sav, 'Delimiter', ' ');
                   next = data{1, 1};
                   waves = [waves next];
            end
           
           waves = transpose(waves);
           xAxis = sort(waves);
           yAxis = transpose(spectras);
           
           param = textscan(fileID, '%d', 2, 'Delimiter', '/');
           data = param{1, 1};
           disp(param)
           
           fclose(filedID);
           
           xDim = data(1);
           yDim = data(2);

          
        end
