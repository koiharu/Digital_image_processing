function outputImage = histogramSpecification(inputImage, targetImage)
    % 如果输入图像是彩色图像，转换为灰度图像
    if size(inputImage, 3) == 3
        inputImage = rgb2gray(inputImage);
    end
    if size(targetImage, 3) == 3
        targetImage = rgb2gray(targetImage);
    end

    % 计算输入图像和目标图像的直方图及其累计分布函数
    [inputHist, ~] = imhist(inputImage);      % 输入图像直方图
    [targetHist, ~] = imhist(targetImage);    % 目标图像直方图
    inputCDF = cumsum(inputHist) / numel(inputImage);  % 输入图像的累计分布函数
    targetCDF = cumsum(targetHist) / numel(targetImage); % 目标图像的累计分布函数

    % 构建映射表
    mapping = zeros(256, 1); % 映射关系
    for grayLevel = 1:256
        [~, idx] = min(abs(inputCDF(grayLevel) - targetCDF)); % 找到最近的目标灰度值
        mapping(grayLevel) = idx - 1; % 映射到目标灰度值
    end 

    % 应用映射表生成输出图像
    outputImage = mapping(double(inputImage) + 1);

    % 转换为uint8类型
    outputImage = uint8(outputImage);
end
