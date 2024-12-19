function filteredImage = customFrequencyFilter(image, filter)
    % 确保图像为灰度图
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % 转换为 double 类型
    image = double(image);

    % 计算傅里叶变换
    fftImage = fft2(image);
    fftImageShifted = fftshift(fftImage);

    % 应用自定义频域滤波器
    filteredFFT = fftImageShifted .* filter;

    % 逆傅里叶变换
    filteredFFTShifted = ifftshift(filteredFFT);
    filteredImage = abs(ifft2(filteredFFTShifted));

    % 转换为 uint8 类型
    filteredImage = uint8(filteredImage);
end