package product;

import java.util.List;

public class ProductService {

    private final ProductRepository repository = new ProductRepository();

    public List<ProductDto> getAllProducts() {
        return repository.findAll();
    }

    // ✅ 새 상품 등록
    public boolean addProduct(ProductDto dto) {
        return repository.insert(dto);
    }

    // ✅ 상품 삭제 서비스 추가
    public boolean removeProduct(int productId) {
        return repository.delete(productId);
    }
}