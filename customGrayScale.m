function grayImage = customGrayScale(rgbImage)
    % 检查输入图像是否为 RGB 图像
    if size(rgbImage, 3) ~= 3
        error('输入图像必须是 RGB 图像');
    end
    
    % 提取 R、G、B 通道
    R = double(rgbImage(:, :, 1)); % 将通道转换为 double 类型
    G = double(rgbImage(:, :, 2));
    B = double(rgbImage(:, :, 3));
    
    % 加权公式计算灰度图像
    grayImage = 0.2989 * R + 0.5870 * G + 0.1140 * B;
    
    % 将结果转换为 uint8 类型
    grayImage = uint8(grayImage);
end