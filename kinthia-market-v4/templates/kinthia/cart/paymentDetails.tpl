{capture assign="headData"}
	<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="{'/javascript/config'|url}"></script>
	{* <script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script> *}
	<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
    <script type="text/javascript" src="{'/user/javascript/profile/indexOnLoad.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/components-shop.js'|resurl}"></script>
{/capture}
{include file="includes/header.tpl" title="{'cartPaymentDetails_html_title'|lang}" metaDescription="{'cartPaymentDetails_meta_description'|lang}"}

<section id="checkout" class="mb-3">
{include file="cart/includes/steps.tpl" step=2}
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<table class="tablepayment w-100">
				<thead>
					<tr>
						<th class="paiementfirst">{'cartPaymentDetails_order_total_price'|lang}</th>
						<th class="none"></th>
					</tr>
				</thead>
				<tbody>
					<tr class="linecheckout1">
						<td class="td_right" style="font-size: 18px;">{'cartPaymentDetails_total_price'|lang}</td>
						<td class="td_price" style="font-size: 18px;">
							{if $cart.type==='VoyantQuestion'}
								{$cart.totalPrice} {'euro_symbole'|lang} TTC
								{* <input type="hidden" name="voyantId" value="{$voyant.voyantId}"> *}
								<input type="hidden" name="stripePublishableKey" value="{$voyant.stripePublishableKey}">
							{/if}
							
							{if $cart.type==='TimePack'}
								{* {$cart.baskets[$packageId].totalPrice} {'euro_symbole'|lang} *} TTC
								{$cart.totalPrice} {'euro_symbole'|lang}
								<input type="hidden" name="userId" value="1">
								{* <input type="hidden" name="stripePublishableKey" value="{$paymentprocessors.stripePublishableKey}"> *}
								<input type="hidden" name="stripePublishableKey" value="pk_test_3QTm41Gsxekm6CDwCFxUg3Eu">
								<input type="hidden" name="packageId" value="{$packageId}">
							{/if}

							{if $cart.type==='Platform'}
								{$cart.totalPrice} {'euro_symbole'|lang} TTC
								<input type="hidden" name="stripePublishableKey" value="{$voyant.stripePublishableKey}">	
								<input type="hidden" name="userId" value="1">
								<input type="hidden" name="voyantId" value="{$voyant.voyantId}">
							{/if}
						</td>
					</tr>
				</tbody>
			</table>

			<!-- start new payment method-->
			<input type="hidden" name="type" value="{$cart.type}" />
			<input type="hidden" name="actionUrl" value="{'/cart/pay'|url}">
			<!--<input type="hidden" name="intentUrl" value="https://www.kinthia.com/test78/cart/getIntent" />-->
			<input type="hidden" name="intentUrl" value="{'/cart/getIntent'|url}" />
			<!--<input type="hidden" name="stripePublishableKey" value="pk_test_3QTm41Gsxekm6CDwCFxUg3Eu">-->
			<table class="tablepayment w-100 mt-3" cellspacing="0">
				<thead>
					<tr>
						<th class="paiementfirst">{'cartPaymentDetails_payment_method'|lang}</th>
					</tr>
				</thead>
				<tbody>
					<tr class="linecheckout1">
						<td class="td_left_explanation_paiement">
							<!--start card payment-->
							<div id ="payment-option-1-container">
								<div class="c-paiement-input">
									<input type="radio" id="payment-option-1" class="c-radio" name="paymentMethod" value="stripe">
								</div>

								<label for="payment-option-1" class="c-paiement-label">
									<div class="">
										<span>Payer par carte bancaire</span>
									</div>
									<div class="">
										<img src="{'/templates/kinthia/images/visa1.png'|resurl}" alt="" class="imagepaiementcard" /> <img src="{'/templates/kinthia/images/master-card1.png'|resurl}" alt="" class="imagepaiementcard" />
									</div>
								</label>
							</div>

							{if isset($cart.type) && !empty($cart.type) && ($cart.type==='VoyantQuestion' || $cart.type==='Platform' || $cart.type==='TimePack')}
							{* {if $voyant.stripeEnable == '1'} *}
				
							<div id="payment-option-1-additional-information" class="margin-t-15 js-additional-information" style="display: none;">
								<p class="txtpaymentexplanation mbs">
								<b>Paiement en ligne 100% sécurisé</b><br>
								Les informations bancaires que vous transmettez en ligne sont cryptées (protocole SSL), rien ne transite en clair sur Internet.<br>
								Aucune information bancaire n'est stocké sur Kinthia.com
								</p>
								<script src="https://js.stripe.com/v3/" data-locale="fr"></script>
								<div class="c-paiement-card">
									<form action="{'/cart/stripeSubmit'|url}" method="post" id="stripePaymentForm">
										<input type="hidden" name="type" value="{$cart.type}" />
										{if isset($voyant.voyantId) && !empty($voyant.voyantId) && $voyant.voyantId > 0 || ($cart.type==='VoyantQuestion' || $cart.type==='Platform')}
										<input type="hidden" name="voyantId" value="{$voyant.voyantId}">
										{/if}
										{* {if $type==='TimePack'}
										<input type="hidden" name="voyantId" value=0>
										{/if} *}
										<input type="hidden" name="packageId" value="{$packageId}">
										<div class="form-row" style="display:block !important;">
											<div id="card-element">
												
												<!-- a Stripe Element will be inserted here. -->
											</div>

											<!-- Used to display form errors -->
											<div id="card-errors" role="alert"></div>
										</div>
									</form>
								</div>
							</div>
								{* {/if} *}
							{/if}
							<!--end card payment-->

							<hr class="c-paiement-hr">
							<!--start paypal payment-->
							<div id ="payment-option-2-container">
								<div class="c-paiement-input">
									<input type="radio" id="payment-option-2" class="c-radio" name="paymentMethod" value="payPal">
								</div>
								<label for="payment-option-2" class="c-paiement-label">
									<img src="{'/templates/kinthia/images/PP_logo_h_100x26.png'|resurl}" alt="" class="imagepaiementpaypal" />
								</label>
							</div>
							<div id="payment-option-2-additional-information" class="margin-t-15 js-additional-information" style="display: none;">
								<div class="c-paiement-txt">
									<p class="txtpaymentexplanation">
									<b>Paiement en ligne 100% sécurisé</b><br />
									Vous allez être redirigé vers une page de paiement 100% sécurisée.<br />
									Les informations bancaires que vous transmettez en ligne sont cryptées (protocole SSL), rien ne transite en clair sur Internet.
									</p>
								</div>
							</div>
							<!--end paypal payment-->
							<hr class="c-paiement-hr">
							<!--start check payment-->
							{if isset($cart.type) && !empty($cart.type) && $cart.type==='VoyantQuestion'}
								{* <div id ="payment-option-3-container">
									<div class="c-paiement-input">
										<input type="radio" id="payment-option-3" class="c-radio" name="paymentMethod" value="check">
									</div>
									<label for="payment-option-3" class="c-paiement-label">
										<span>Payer par chèque</span>
									</label>
								</div> *}
								<div id="payment-option-3-additional-information" class="margin-t-15 js-additional-information" style="display: none;">
									<div class="c-paiement-txt">
									<p class="txtpaymentexplanation">Pour payer par chèque, merci d'envoyer votre chèque à l'adresse ci-dessous :</p>
										<dl class="payment-method txtpaymentexplanation">
											<dt>Bénéficiaire</dt>
											{if $cart.type==='VoyantQuestion'}
											<dd>{$voyant.firstName} {$voyant.lastName}</dd>
											<dt>Envoyez votre chèque à cette adresse</dt>
											<dd>{$voyant.address}<br />
												{$voyant.zipCode} {$voyant.city}</dd>
											{/if}
											{* {if $type==='TimePack'}

											<!---Here Platform Detail will come for Checq Book -->
												<dd>{$user.firstName} {$user.lastName}</dd>
												<dt>Envoyez votre chèque à cette adresse</dt>
												<dd>{$user.address}<br />
												{$user.zipCode} {$user.city}</dd>
											{/if} *}
										</dl>
										<p class="txtpaymentexplanation">En appuyant sur le bouton, "<span class="txtuppercase">Procéder au paiement</span>", un numéro de commande sera créé, votre paiement sera en attente jusqu'à ce que le voyant reçoit le chèque.<br />
										Une fois le chèque reçu, un email vous sera envoyé, le voyant prendra contact avec vous.<br />
										Une facture sera éditée, et votre commande pourra être traitée par le voyant.
										</p>
									</div>
								</div>
							{/if}
							<!--end check payment-->
						</td>
					</tr>
				</tbody>
			</table>

			<div class="w-100 text-center mt-3">
				En passant la commande, vous attestez avoir lu les <a href="https://www.kinthia.com/copyright/termes.php#cgv" class="linkcgv" target="_blank">conditions générales de vente</a> et y adhèrer sans réserve.
			</div>
			<div class="w-100 text-center mt-3 payment-errors">
			</div>
			<div class="w-100 text-center my-3">
				<button id="buttonValidator" type="submit" class="btn btn-kin-orange fsize-18 payment-button-new">Procécder au paiement</button>
			</div>
			<!-- end new payment method-->

			<div class="padding-wrapper aftermenutop">
				<div id="breadcrumb">
					<a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
					<a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt; <a href="{'/cart/checkout'|url}" class="link_showarbo">{'cartCheckout_arbo'|lang}</a> &gt; {'cartPaymentDetails_arbo'|lang}
				</div>
			</div>
		</div>
	</div>
</div>

{include file="includes/footer.tpl"}