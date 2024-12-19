function rotatedImage = rotateImageBilinear(image, angle)
    % 将角度转换为弧度
    angleRad = deg2rad(angle);
    
    % 获取图像尺寸
    [rows, cols, numChannels] = size(image);

    % 计算旋转中心
    centerX = ceil(cols / 2);
    centerY = ceil(rows / 2);

    % 创建空画布
    rotatedImage = uint8(zeros(size(image)));

    % 遍历目标图像的每个像素
    for xNew = 1:cols
        for yNew = 1:rows
            % 计算相对于中心的坐标
            xRel = xNew - centerX;
            yRel = yNew - centerY;

            % 使用旋转矩阵计算源坐标
            xOld = centerX + xRel * cos(angleRad) - yRel * sin(angleRad);
            yOld = centerY + xRel * sin(angleRad) + yRel * cos(angleRad);
            
            % 检查源坐标是否在图像范围内
            if xOld >= 1 && xOld <= cols && yOld >= 1 && yOld <= rows
                % 获取四个最近邻像素的位置及其颜色值
                x1 = floor(xOld); y1 = floor(yOld);
                x2 = ceil(xOld); y2 = ceil(yOld);
                
                if x1 == 0, x1 = 1; end
                if x2 == 0, x2 = 1; end
                if y1 == 0, y1 = 1; end
                if y2 == 0, y2 = 1; end
                
                for c = 1:numChannels
                    % 获取四个像素的颜色值
                    Q11 = double(image(y1, x1, c));
                    Q21 = double(image(y1, x2, c));
                    Q12 = double(image(y2, x1, c));
                    Q22 = double(image(y2, x2, c));
                    
                    % 双线性插值计算新像素的颜色值
                    fxy1 = (x2 - xOld) * Q11 + (xOld - x1) * Q21;
                    fxy2 = (x2 - xOld) * Q12 + (xOld - x1) * Q22;
                    fxy = (y2 - yOld) * fxy1 + (yOld - y1) * fxy2;
                    
                    rotatedImage(yNew, xNew, c) = uint8(fxy);
                end
            end
        end
    end
end