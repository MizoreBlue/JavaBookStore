document.addEventListener('DOMContentLoaded', function() {
    const carouselImages = document.querySelectorAll('.carousel img');
    const indicators = document.querySelectorAll('.carousel-indicators span');
    let currentIndex = 0;

    function showImage(index) {
        carouselImages.forEach(img => img.classList.remove('active'));
        indicators.forEach(indicator => indicator.classList.remove('active'));

        carouselImages[index].classList.add('active');
        indicators[index].classList.add('active');
    }

    function nextImage() {
        currentIndex = (currentIndex + 1) % carouselImages.length;
        showImage(currentIndex);
    }

    // 自动轮播
    setInterval(nextImage, 3000);

    // 点击指示器切换
    indicators.forEach((indicator, index) => {
        indicator.addEventListener('click', () => {
            currentIndex = index;
            showImage(currentIndex);
        });
    });
});