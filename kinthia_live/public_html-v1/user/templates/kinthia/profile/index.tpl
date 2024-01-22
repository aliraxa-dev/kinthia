{capture assign="headData"}
	<link href="{'/javascript/jquery/theme/jquery-ui.css'|resurl}" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="{'/javascript/config'|url}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-3.4.1.min.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-tools/jquery-tools.min.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-ui/jquery-ui.min.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.autoFill.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.form.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.formTool.js'|resurl}"></script>
	<script type="text/javascript" src="{'/javascript/jquery/jquery-validate/jquery.validate.min.js'|resurl}"></script>
    <script type="text/javascript" src="{'/javascript/jquery/jquery.popup.js'|resurl}"></script>
    <script type="text/javascript" src="{'/user/javascript/profile/indexOnLoad.js'|resurl}"></script>
    <script type="text/javascript">
        setting.user = {$userJson|htmlspecialchars_decode};
        setting.returnUrl = "{'/user/management'|url}";

        var pendingMsg = new Array();
        pendingMsg.pendingVoyantEmailsIds = {$pendingVoyantEmailsIds|htmlspecialchars_decode};
    </script>
    <script type="text/javascript" src="{'/user/javascript/order/indexOnLoad.js'|resurl}"></script>
{/capture}

{include file="includes/header.tpl" title="{'profileIndex_title_html'|lang}" metaDescription="{'profileIndex_meta_description'|lang}"}

<section id="user-profile">
<div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div id="breadcrumb">
                    <a href="https://www.kinthia.com/">{'show_arbo_voyance'|lang}</a> &gt;
                    <a href="{'/'|url}">{'show_arbo_tirage'|lang}</a> &gt;
                    <a href="{'/user'|url}">{'managementIndex_arbo'|lang}</a> &gt;
                    <a href="{'/user/profile'|url}">{'profileIndex_arbo'|lang}</a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                {include file="includes/profileMenu.tpl"}
            </div>
        </div>



        <div class="row">
            <div class="col-lg-12">
        <div class="login-container">
            <h2 class="voyanth1">{'profileIndex_h1'|lang}</h2>

            <div class="form-group">
                <label class="form-check-label">{'profileIndex_desc'|lang}</label>
            </div>
            <div class="form-group">
                <label><b>{'profileIndex_pseudo'|lang}</b>:  {$user.name}</label>
            </div>
            <div class="form-group">
                <label><b>{'profileIndex_email'|lang}</b>:  {$user.email} - <a href="{'/user/profile/changeEmail'|url}"
                                                      title="{'mainLogin_forgot_pass'|lang}" onclick="return false"
                                                      class="linklostpassword change-email-link" id="changeEmailLink">change
                        email</a></label>
            </div>
            <div class="form-group">
                <label><b>{'profileIndex_change_password'|lang}</b>:  <a href="{'/user/profile/changePassword'|url}"
                       class="linklostpassword change-password-link"
                       onclick="return false"
                       id="changePasswordLink">{'profileIndex_change_password_click_here'|lang}</a></label>
            </div>
        </div>


        <form action="{'/user/profile/save'|url}" method="post" id="personalInformationsForm">
            <div class="login-container" id="registerLayer">
                <h2 class="voyanth1">{'profileIndex_h1_personnal_information'|lang}</h2>

                <div class="form-group">
                <label for="namePrefix">{'profileIndex_title'|lang}</label>
                <div class="input-group mb-3">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="namePrefix" value="Mrs."/>
                        <label class="form-check-label" for="namePrefix">{'profileIndex_melle'|lang}</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="namePrefix" value="Ms."/>
                        <label class="form-check-label" for="inlineRadio2">{'profileIndex_madame'|lang}</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="namePrefix" value="Mr."/>
                        <label class="form-check-label" for="inlineRadio3">{'profileIndex_monsieur'|lang}</label>
                    </div>
                </div>




                <div class="form-group">
                <label for="firstName">{'profileIndex_first_name'|lang}</label>
                    <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="{'profileIndex_first_name'|lang}" name="firstName" value=""/>
                    </div>
                </div>

                <div class="form-group">
                <label for="lastName">{'profileIndex_last_name'|lang}</label>
                    <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="{'profileIndex_last_name'|lang}" name="lastName" value=""/>
                    </div>
                </div>

                <div class="form-group">
                <label for="birthdayDate">{'profileIndex_birthdate'|lang}</label>
                    <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="jj/mm/aaaa" name="birthdayDate" value=""/>
                    <div id="errordiv"></div>
                    </div>
                </div>

                <div class="form-group">
                <label for="phone">{'profileIndex_phone'|lang}</label>
                    <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="{'profileIndex_phone'|lang}" name="phone" value=""/>
                    </div>
                </div>

                <div class="form-group">
                <label for="mobilePhone">{'profileIndex_mobile_phone'|lang}</label>
                    <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="{'profileIndex_mobile_phone'|lang}" name="mobilePhone" value=""/>
                    </div>
                </div>

                 <div class="form-group">
                <label for="mobilePhone">{'profileIndex_mobile_phone'|lang}</label>
                    <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="{'profileIndex_mobile_phone'|lang}" name="mobilePhone" value=""/>
                    </div>
                </div>

                <div class="form-group form-check">
                    <input type="checkbox" name="newsletterEnabled" value="1" class="form-check-input">
                    <label class="form-check-label" for="newsletterEnabled">{'profileIndex_newsletter'|lang}</label>
                </div>

                <button type="submit" class="btn btn-primary w-100 text-uppercase">{'profileIndex_save'|lang}</button>
            </div>
        </form>

            </div>
        </div>
    </div>
</section>

{include file="includes/footer.tpl"}