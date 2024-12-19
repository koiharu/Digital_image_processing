function filteredImage = customSpatialFilter(image, kernel)
    % 检查图像是否为灰度图
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % 确保图像为 double 类型
    image = double(image);

    % 获取滤波器尺寸
    [kRows, kCols] = size(kernel);
    padRows = floor(kRows / 2);
    padCols = floor(kCols / 2);

    % 对图像进行边界填充
    paddedImage = padarray(image, [padRows, padCols], 'replicate');

    % 初始化结果图像
    [rows, cols] = size(image);
    filteredImage = zeros(rows, cols);

    % 应用卷积
    for i = 1:rows
        for j = 1:cols
            region = paddedImage(i:i + kRows - 1, j:j + kCols - 1);
            filteredImage(i, j) = sum(sum(region .* kernel));
        end
    end

    % 转换为 uint8 类型
    filteredImage = uint8(filteredImage);
end