function data = reader(file) 
    file_ = fopen(file);
    data_ = textscan(file, '%s%s%d', 'Delimiter',',', 'CollectOutput',1);
    data = data_;
    fclose = (file);
end