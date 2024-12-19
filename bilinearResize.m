function resizedImage = bilinearResize(image, scale)
    % 获取输入图像尺寸
    [rows, cols, channels] = size(image);

    % 计算输出图像尺寸
    newRows = round(rows * scale);
    newCols = round(cols * scale);

    % 初始化输出图像
    resizedImage = zeros(newRows, newCols, channels, 'uint8');

    % 双线性插值
    for i = 1:newRows
        for j = 1:newCols
            % 计算对应的输入位置
            x = (i - 0.5) / scale + 0.5;
            y = (j - 0.5) / scale + 0.5;

            % 获取邻近的四个像素位置
            x1 = floor(x); x2 = ceil(x);
            y1 = floor(y); y2 = ceil(y);

            % 边界处理
            x1 = max(min(x1, rows), 1); x2 = max(min(x2, rows), 1);
            y1 = max(min(y1, cols), 1); y2 = max(min(y2, cols), 1);

            % 插值权重
            dx = x - x1; dy = y - y1;

            % 插值计算
            for c = 1:channels
                resizedImage(i, j, c) = (1 - dx) * (1 - dy) * image(x1, y1, c) + ...
                                        dx * (1 - dy) * image(x2, y1, c) + ...
                                        (1 - dx) * dy * image(x1, y2, c) + ...
                                        dx * dy * image(x2, y2, c);
            end
        end
    end
end