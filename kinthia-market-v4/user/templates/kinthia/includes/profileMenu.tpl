<div id="usermenu">
	<ul>
		<li id="first"><a href="{'/user/profile'|url}"><i class="fas fa-user"></i> {'Mon compte'|lang}</a></li>
		<li id="order"><a href="{'/user/order'|url}"><i class="fas fa-list"></i> {'Mes consultations'|lang} ({math equation="($session.user.ordersCount + $session.totalConsultationUserCount)"})  </a></li>
		<li id="first"><a href="{'/user/order/orderList'|url}"><i class="fas fa-id-card"></i> {'Mes paiements'|lang}</a></li>
		<li id="first"><a href="{'/user/privateMessage'|url}"><i class="fas fa-book"></i></i> {'Private Message'|lang} (<span id="pMess"></span>)</a></li>
		<li id="first"><a href="{'/user/fav'|url}"><i class="fas fa-heart"></i> {'Expert favoris'|lang}</a></li>
		<li id="first"><a href="{'/user/alert'|url}"><i class="fas fa-bell"></i> {'Mes alertes'|lang}</a></li>
		<!--
		<li class="other"><a href="{'/user/profile/photo'|url}">{'profileMenu_photo'|lang} ({$session.user.photosCount})</a></li>
	-->
	</ul>

	<form action="{'/user/privateMessage/getPrivateMessage'|url}" method="post" id="getPrivateMsg">
		<input type="hidden" name="voyantEmailId" id="voyantEmailId" value="">
	</form>
</div>
