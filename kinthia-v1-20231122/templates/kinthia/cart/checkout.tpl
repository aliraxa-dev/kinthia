{capture assign="headData"}
{/capture}

{include file="includes/header.tpl" title="{'cartCheckout_html_title'|lang}" metaDescription="{'cartCheckout_meta_description'|lang}"}

<section id="checkout">
	<div class="container">
		{include file="cart/includes/steps.tpl" step=1}
		{foreach from=$cart.baskets item=basket}
			{if $basket.type == 'Platform'}
				<form action="{"/cart/paymentDetails/$basket.voyant.voyantId/$basket.package.packageId/$basket.type"|url}" method="post">
					{foreach from=$basket.items item=item}
						<div class="row">
							<div class="col-lg-12">
								<table class="tablepayment w-100">
									<thead>
										<tr>
											{if $item.type == 'VoyantQuestion'}
												<th class="paiementfirst">{'cartCheckout_table_item'|lang} {$item.voyantName}</th>
											{/if}
											{if $item.type == 'TimePack'}
												<th class="paiementfirst">{'Pack Time - Can be used with all experts'}</th>
											{/if}
											<th class="paiementcenter">{'cartCheckout_quantity'|lang}</th>
											<th class="paiementcenter">{'cartCheckout_price'|lang}</th>
											<th class="paiementcenter"></th>
										</tr>
									</thead>
									<tbody>
										<tr class="linecheckout{cycle values='1,2'}">
											<td class="td_left">
												<span>{$item.name}</span>
											</td>	
											<td class="td_center">
												<span class="paiementquantity">{$item.quantity}</span>
											</td>
											<td class="td_center">
												<span class="pricepayment">
													{$item.totalPrice}{'euro_symbole'|lang}
												</span>
											</td>
											<td class="td_center">
												<a href="{"/cart/deleteItem/$item.cartItemId"|url}" class="linkdelete">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
														<path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5Zm-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5ZM4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5Z"/>
													</svg>
												</a>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					{/foreach}

					<div class="row">
						<div class="col-lg-12">
							<div class="divpaymenttotal">
								<div class="checkout-cart-total">
									{'cartCheckout_caddies_total'|lang}
								</div>
								<div class="checkout-cart-total-price">
									{'cartCheckout_total_price'|lang} <span>{$basket.totalPrice} {'euro_symbole'|lang} TTC</span>
								</div>
								<div>
									<button type="submit" value="Submit" class="btn btn-kin-orange w-100 fsize-16 mt-1 mb-4">Commander</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			{/if}
			{if $basket.type == 'VoyantQuestion'}
				{foreach from=$cart.voyantIds item=voyantId}
					{if $basket.voyant.voyantId == $voyantId}
						<form action="{"/cart/paymentDetails/$voyantId/0/$basket.type"|url}" method="post">	
							<div class="row">
								<div class="col-lg-12">
									<table class="tablepayment w-100">
										<thead>
											<tr>
												<th class="paiementfirst">{'cartCheckout_table_item'|lang} {$basket.voyant.name}</th>
												<th class="paiementcenter">{'cartCheckout_quantity'|lang}</th>
												<th class="paiementcenter">{'cartCheckout_price'|lang}</th>
												<th class="paiementcenter"></th>
											</tr>
										</thead>
										<tbody>
											{foreach from=$basket.items item=item}
												<tr class="linecheckout{cycle values='1,2'}">
													<td class="td_left">
														<span>{$item.name}</span>
													</td>	
													<td class="td_center">
														<span class="paiementquantity">{$item.quantity}</span>
													</td>
													<td class="td_center">
														<span class="pricepayment">
															{$item.totalPrice}{'euro_symbole'|lang}
														</span>
													</td>
													<td class="td_center">
														<a href="{"/cart/deleteItem/$item.cartItemId"|url}" class="linkdelete">
															<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#000" viewBox="0 0 16 16">
																<path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5Zm-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5ZM4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5Z"/>
															</svg>
														</a>
													</td>
												</tr>
											{/foreach}
										</tbody>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="divpaymenttotal">
										<div class="checkout-cart-total">
											{'cartCheckout_caddies_total'|lang}
										</div>
										<div class="checkout-cart-total-price">
											{'cartCheckout_total_price'|lang} <span>{$basket.totalPrice} {'euro_symbole'|lang} TTC</span>
										</div>
										<div>
											<button type="submit" value="Submit" class="btn btn-kin-orange w-100 fsize-16 mt-1 mb-4">Commander</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					{/if}
				{/foreach}
			{/if}
		{/foreach}
		
	</div>
</section>

{include file="includes/footer.tpl"}

{* -- START - DO NOT DISPLAY --
	<div id="breadcrumb">
	<a href="https://www.kinthia.com/" class="link_showarbo">{'show_arbo_voyance'|lang}</a> &gt; 
	<a href="{'/'|url}" class="link_showarbo">{'show_arbo_tirage'|lang}</a> &gt; 
	<a href="{'/cart/checkout'|url}" class="link_showarbo">{'cartCheckout_arbo'|lang}</a>
	</div>
-- START - DO NOT DISPLAY -- *}

