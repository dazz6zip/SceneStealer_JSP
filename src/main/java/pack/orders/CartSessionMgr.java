package pack.orders;

import java.util.Hashtable;

public class CartSessionMgr {
	//cart 세션 전용 부분
	private Hashtable<String, Order_productDto> hCart = new Hashtable<String, Order_productDto>();
	
	public void addCart(Order_productDto opdto) {
		String product_name = opdto.getName();
		int quantity = opdto.getQuantity();
		
		System.out.println("Adding to cart: " + product_name + ", Quantity: " + quantity);
		
		if(quantity > 0) {
			// 동일 상품 주문인 경우에는 주문 수량만 누적되게 해야되(containsKey)
			if(hCart.containsKey(product_name)) { // 이미 1회에 이상 주문된 상품인 경우
				// 누적을 위해서 꺼내야되
				Order_productDto temp = hCart.get(product_name);
				quantity += temp.getQuantity(); //누적
				temp.setQuantity(quantity);
				hCart.put(product_name, temp);
				 System.out.println("Updated product in cart: " + temp.getName() + ", New Quantity: " + temp.getQuantity());
			}else {
				hCart.put(product_name, opdto); 
				// 카트에 아무 물건도 안 담가져 있을 때 담기는 최초의 상품 (상품의 종류가 달라짐)
				 System.out.println("New product added to cart: " + opdto.getName() + ", Quantity: " + opdto.getQuantity());
			}
		}
	}
	
	// 카트 읽기
	public Hashtable<String, Order_productDto> getCartList(){
		return hCart;
	}
	
	//장바구니 내용 수정 ( 주문수량 수정)
		public void updateCart(Order_productDto opdto) {
			String product_name = opdto.getName();
			hCart.put(product_name, opdto); // 넣을 때에는 put
			
		}
		//장바구니 내용 삭제
		public void deleteCart(Order_productDto opdto) {
			String product_name = opdto.getName();
			hCart.remove(product_name); // 지울 때에는 remove
			// 카트는 데이터에 들어가 있지 않고 Lam으로 저장
		}
	}

