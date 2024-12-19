function enhancedImg = enhanceContrast(grayImg, method)
    % 输入检查
    if size(grayImg, 3) == 3
        grayImg = rgb2gray(grayImg);
    end

    % 转换为双精度以避免溢出
    grayImg = double(grayImg);

    if strcmp(method, 'linear') % 线性变换
        % 应用线性增强公式
        enhancedImg = 1.5 * grayImg - 30;
    
        % 将像素值限制在 [0, 255] 范围
        enhancedImg = max(min(enhancedImg, 255), 0);
    
        % 转换为 uint8 类型
        enhancedImg = uint8(enhancedImg);

    elseif strcmp(method, 'log') % 非线性变换（对数变换）
        % 计算缩放常数 c
        c = 255 / log(1 + max(grayImg(:)));
        
        % 应用对数变换
        enhancedImg = c * log(1 + grayImg);
        
        % 将处理后的图像转换为 uint8 类型，便于显示
        enhancedImg = uint8(enhancedImg);
    elseif strcmp(method, 'exponential')% 非线性变换（指数变换）
        % 归一化到 [0, 1] 范围
        grayImg = grayImg / 255;
    
        % 应用指数增强公式
        enhancedImg = 1.0 * (grayImg .^ 0.5);
    
        % 恢复到 [0, 255] 范围
        enhancedImg = enhancedImg * 255;
    
        % 将像素值限制在 [0, 255] 范围
        enhancedImg = max(min(enhancedImg, 255), 0);
    
        % 转换为 uint8 类型
        enhancedImg = uint8(enhancedImg);
    end

end