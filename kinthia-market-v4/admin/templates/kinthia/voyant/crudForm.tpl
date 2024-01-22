
<!-- /.content-header -->

<!-- Main content -->
<div class="content">
    <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
               <div class="card-header">
                <h3 class="card-title">Personnal information</h3>
                {*  {include file="includes/tableNavigation.tpl"} *}
            </div>
            <!-- /.card-header -->
            <form action="{"/admin/voyant/save"|url}" method="post" enctype="multipart/form-data" id="editVoyantFormnew">
              <div class="card-body table-responsive p-0">
                  {if !empty($edit)}
                  <input type="hidden" name="voyantId" value="" />
                  <input type="hidden" class="input_text_medium" name="displayPhone" value=" {$voyant.displayPhone}" /> 
                  <input type="hidden" class="input_text_medium" name="displayWebcam" value=" {$voyant.displayWebcam}" />
                  <input type="hidden" class="input_text_medium" name="displayEmail" value=" {$voyant.displayEmail}" />
                  {else}
                  <input type="hidden" name="tempId" value="{$tempId}" />
                  {/if}
                 
                  

                  <table class="table text-nowrap">
                    <tbody>
                        <tr>
                            <td>Voyant is available : </td>
                            <td><input type="radio" name="available" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="available" value="0" /> OFF</td>
                        </tr>
                        <tr>
                            <td>Pseudo: </td>
                            <td><input type="text" class="input_text_medium" name="name" value="" /></td>
                        </tr>
                        <tr>
                            <td>Display pseudo on invoice : </td>
                            <td><input type="radio" name="displayNameOnInvoice" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="displayNameOnInvoice" value="0" /> OFF</td>
                        </tr>
                        <tr>
                            <td>First name: </td>
                            <td><input type="text" class="input_text_medium" name="firstName" value="" /></td>
                        </tr>
                        <tr>
                            <td>Display fist name on invoice : </td>
                            <td><input type="radio" name="displayFirstNameOnInvoice" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="displayFirstNameOnInvoice" value="0" /> OFF</td>
                        </tr>
                        <tr>
                            <td>Last name: </td>
                            <td><input type="text" class="input_text_medium" name="lastName" value="" /></td>
                        </tr>
                        <tr>
                            <td>Display last name on invoice : </td>
                            <td><input type="radio" name="displayLastNameOnInvoice" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="displayLastNameOnInvoice" value="0" /> OFF</td>
                        </tr>
                        <tr>
                            <td>Adress: </td>
                            <td><input type="text" class="input_text_large" name="address" value="" /></td>
                        </tr>
                        <tr>
                            <td>Postal code: </td>
                            <td><input type="text" class="input_text_small" name="zipCode" value="" /></td>
                        </tr>
                        <tr>
                            <td>City: </td>
                            <td><input type="text" class="input_text_medium" name="city" value="" /></td>
                        </tr>
                        <tr>
                            <td>Country (toAdd): </td>
                            <td><input type="text" class="input_text_medium" name="country" value="" /></td>
                        </tr>
                        <tr>
                            <td>Company name (toAdd): </td>
                            <td><input type="text" class="input_text_large" name="companyName" value="" /></td>
                        </tr>
                        <tr>
                            <td>Company format (toAdd): </td>
                            <td><input type="text" class="input_text_large" name="companyFormat" value="" /></td>
                        </tr>
                        <tr>
                            <td>Company Tax number: </td>
                            <td><input type="text" class="input_text_large" name="companyTaxNumber" value="" /></td>
                        </tr>
                        <tr>
                            <td>TVA (%): </td>
                            <td><input type="text" class="input_text_small" name="tva" value="" /></td>
                        </tr>
                        <tr>
                            <td>Display TVA on invoice : </td>
                            <td><input type="radio" name="displayTvaOnInvoice" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="displayTvaOnInvoice" value="0" /> OFF</td>
                        </tr>
                        <tr>
                            <td>IBAN (toAdd): </td>
                            <td><input type="text" class="input_text_large" name="bankIban" value="" /></td>
                        </tr>
                        <tr>
                            <td>BIC (toAdd): </td>
                            <td><input type="text" class="input_text_large" name="bankBic" value="" /></td>
                        </tr>
                        <tr>
                            <td>Email: </td>
                            <td><input type="text" class="input_text_large" name="email" value="" /></td>
                        </tr>
                        <tr>
                            <td>Phone number (toAdd): </td>
                            <td><input type="text" class="input_text_large" name="phoneNumber" value="" /></td>
                        </tr>
                        <tr>
                            <td>Mobile number (toAdd): </td>
                            <td><input type="text" class="input_text_large" name="mobileNumber" value="" /></td>
                        </tr>
                        <tr>
                            <td>{if $edit}New password{else}Password{/if}: </td>
                            <td><input type="password" class="input_text_large" name="password" value="" /></td>
                        </tr>
                        <tr>
                            <td>Sexe : </td>
                            <td><input type="radio" name="gender" value="M" checked="checked" /> Man &nbsp;&nbsp;<input type="radio" name="gender" value="F" /> Woman</td>
                        </tr>
                        <tr>
                            <td>Languages: </td>
                            <td>
                               {foreach from=$languages item=language}
                               <input {if $edit && $language.languageId|in_array:$voyantData[language_id]}   checked="" {/if} type="checkbox" name="languages[]" value="{$language.languageId}" /> {$language.language}<br>
                               {/foreach}
                           </td>
                       </tr>
                       <tr>
                        <td>Skill: </td>
                        <td>
                           {foreach from=$skills item=skill}
                           
                           <input {if $edit && $skill.skillId|in_array:$voyantData[skill_ids]}   checked="" {/if}  type="checkbox" name="skills[]" value="{$skill.skillId}" /> {$skill.name}<br>
                           
                           
                           {/foreach}
                       </td>
                   </tr>
                   <tr>
                    <td>Consultation: </td>
                    <td>
                        {foreach from=$consultations item=consultation}
                        <input {if $edit && $consultation.id|in_array:$voyantData[consultation_ids]}   checked="" {/if} type="checkbox" name="consultations[]" value="{$consultation.id}" /> {$consultation.name}<br>
                        {/foreach}
                    </td>
                </tr>
                <tr>
                    <td>Voyant description: </td>
                    <td><textarea class="textarea_large tinyMce" name="voyantDescription" cols="50" rows="5" id="voyantDescription"></textarea></td>
                </tr>
                <tr>
                    <td>Short description: </td>
                    <td><textarea class="textarea_large tinyMce" name="shortDescription" cols="50" rows="5" id="shortDescription"></textarea></td>
                </tr>
                <tr>
                    <td>Voyant quote: </td>
                    <td><textarea class="textarea_large tinyMce" name="voyantQuote" cols="50" rows="5" id="voyantQuote"></textarea></td>
                </tr>
                <tr>
                    <td>Hourly: </td>
                    <td><textarea class="textarea_large tinyMce" name="hourlyDescription" cols="50" rows="5" id="hourlyDescription"></textarea></td>
                </tr>
                <tr>
                    <tr>
                        <td>Contact possibilites: </td>
                        <td><textarea class="textarea_large tinyMce" name="contactDescription" cols="50" rows="5" id="contactDescription"></textarea></td>
                    </tr>
                    <tr>
                        <td>Support divinatory: </td>
                        <td><textarea class="textarea_large tinyMce" name="supportDescription" cols="50" rows="5" id="supportDescription"></textarea></td>
                    </tr>
                    <td>Image:</td>
                    <td><div id="fileUploadPanel" class="fileUploader"></div></td>
                </tr>
            </tr>
            <tr>
                <td>Audio presentation:</td>
                <td>
                    <div>
                        {if !empty($voyantData[audioSrc])}
                        <div id="edit-audio">
                            <span>{$voyantData[audioSrc]}</span>
                            <br>
                            <button style="display:block;width:100px;" onclick="event.preventDefault();document.getElementById('audioFileExist').click();">Change</button>
                        </div>
                        <button id="removeAudioButton" style="display:block;width:100px;" onclick="event.preventDefault();removeAudio();">Remove</button>
                        <input type="file" id="audioFileExist" name="audioFile" style="display:none">
                        {else}
                        <input type="file" id="audioFile" name="audioFile">
                        {/if}
                    </div>
                </td>
            </tr>
        </tr>
        <tr>
            <td>Priority:</td>
            <td><select name="priority" class="select-categoriesandgames">
             <option label="0" value="0">0</option>
             <option label="1" value="1">1</option>
             <option label="2" value="2">2</option>
             <option label="3" value="3">3</option>
             <option label="4" value="4">4</option>
             <option label="5" value="5">5</option>
             <option label="6" value="6">6</option>
             <option label="7" value="7">7</option>
             <option label="8" value="8">8</option>
             <option label="9" value="9">9</option>
             <option label="10" value="10">10</option>
         </select></td>
     </tr>
     <tr>
        <th class="paiement">SEO</th>
        <th class="paiement"></th>
    </tr>
    <tr>
        <td>HTML TITLE: </td>
        <td><input type="text" class="input_text_large" name="title" value="" /></td>
    </tr>
    <tr>
        <td>Meta description: </td>
        <td><input type="text" class="input_text_large" name="metaDescription" value="" /></td>
    </tr>
    <tr>
        <td>H1: </td>
        <td><input type="text" class="input_text_large" name="headerDescription" value="" /></td>
    </tr>
    <tr>
        <td>Navigation Name: </td>
        <td><input type="text" class="input_text_large" name="navigationName" value="" /></td>
    </tr>

    <tr>
        <th class="paiement">Payment - pay back money to the expert</th>
        <th class="paiement"></th>
    </tr>
    <tr>
        <td>Email:<br>
        Gain paid back to the expert for a question (%) - excluding taxes</td>
        <td><input type="text" class="input_text_large" name="paidBackQuestion" value="" /></td>
    </tr>
    <tr>
        <td>Phone:<br>
        Gain paid back to the expert for 1 minute (€) - excluding taxes</td>
        <td><input type="text" class="input_text_large" name="paidBackPhone" value="" /></td>
    </tr>
    <tr>
        <td>Webcam:<br>
        Gain paid back to the expert for 1 minute (€) - excluding taxes</td>
        <td><input type="text" class="input_text_large" name="paidBackWebcam" value="" /></td>
    </tr>

    <tr>
        <th class="paiement">Payment Item question - Who is paid </th>
        <th class="paiement"></th>
    </tr>
    <tr>
        <td>Expert or plateform: (ToAdd) </td>
        <td><input type="radio" name="paymentExpertPlatform" value=1 checked="checked" /> Expert &nbsp;&nbsp;<input type="radio" name="paymentExpertPlatform" value="" /> Plateform</td>
    </tr>

    <tr>
        <th class="paiement">Payment Method - PayPal</th>
        <th class="paiement"></th>
    </tr>
    <tr>
        <td>Enable/Disable: </td>
        <td><input type="checkbox" class="checkbox" name="payPalEnableDisable" value=""> Enable PayPal</td>
    </tr>
    <tr>
        <td>Paypal account: </td>
        <td><input type="text" class="input_text_large" name="payPalEmail" value="" /></td>
    </tr>

    <tr>
        <th class="paiement">Payment Method - Stripe</th>
        <th class="paiement"></th>
    </tr>
    <tr>
        <td>Enable/Disable: </td>
        <td><input type="radio" name="stripeEnable" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="stripeEnable" value="0" /> OFF</td>
    </tr>
    <tr>
        <td>Webhook EndPoints: </td>
        <td>You must had the webhook endoint https://www.kinthia.com/tirage-voyance/?wc-api=wc_stripe to your Stripe Account Settings <a href="https://dashboard.stripe.com/account/webhooks" target="_blank">Here</a> so you can receive notifications on the charge statuses</td>
    </tr>
    <tr>
        <td>Publishable key: </td>
        <td><input type="text" class="input_text_large" name="stripePublishableKey" value="" /></td>
    </tr>
    <tr>
        <td>Secret key: </td>
        <td><input type="text" class="input_text_large" name="stripeSecretKey" value="" /></td>
    </tr>
    <tr>
        <td>Statement Descriptor: </td>
        <td><input type="text" class="input_text_large" name="stripeStatementDescriptor" value="" /></td>
    </tr>
    <tr>
        <td>Capture: Capture charge immediatly</td>
        <td><input type="radio" name="stripeCaptureCharge" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="stripeCaptureCharge" value="0" /> OFF</td>
    </tr>
    <tr>
        <td>Payment Request Buttons:

        </td>
        <td><input type="radio" name="stripePaymentRequestButtons" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="stripePaymentRequestButtons" value="0" /> OFF
            <br>
            Enable Payment Request Buttons. (Apple Pay/Chrome Payment Request API).<br>
            By using Apple Pay, you agree to <a href="https://stripe.com/apple-pay/legal" target="_blank">Stripe</a> and
            <a href="https://developer.apple.com/apple-pay/acceptable-use-guidelines-for-websites/" target="_blank">Apple</a>'s terms of service.</td>
        </tr>
        <tr>
            <td>Saved Cards: Enable payment via Saved Cards</td>
            <td><input type="radio" name="stripeSavedCards" value="1" checked="checked" /> ON &nbsp;&nbsp;<input type="radio" name="stripeSavedCards" value="0" /> OFF</td>
        </tr>




        <tr>
            <td></td>
            <td>
                {if !empty($edit)}
                <input type="submit" class="button" value="Edit Voyant" /> <input type="button" class="button" value="Delete Voyant" name="cancelButton" onclick="if (confirm('Do you really want to delete it?')) window.location.href = AppRouter.getRewrittedUrl('/admin/voyant/delete/{$voyant.voyantId}');"  />
                {else}    
                <input type="submit" class="button" value="Create Voyant" />
                {/if}
            </td>
        </tr>
    </tbody>
</table>
</div>
</form>
</div>
</div>
</div>
</div>
</div>
