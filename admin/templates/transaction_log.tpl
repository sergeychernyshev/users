  {if !empty($message) }
    {foreach from=$message item=msg}
    <h2>{$msg}</h2>
    {/foreach}
  {/if}
  {if empty($fatal) }
	<link rel="stylesheet" type="text/css" href="{$USERSROOTURL}/calendarview/stylesheets/calendarview.css" />
	<style>
		.calendarButton {
      margin: 0em;
			padding: 1px 6px;
      letter-spacing: normal;
      word-spacing: normal;
      line-height: normal;
      text-transform: none;
      text-indent: 0px;
      text-shadow: none;
      display: inline-block;
			border: 1px solid black;
			cursor: pointer;
		}
		div.calendar.popup {
			margin-left: 0px;
			margin-top: 30px;
		}
	</style>

	<script type="text/javascript" src="{$USERSROOTURL}/calendarview/javascripts/prototype.js"></script>
	<script type="text/javascript" src="{$USERSROOTURL}/calendarview/javascripts/calendarview.js"></script>
	<script type="text/javascript">
		window.onload = function() {
		Calendar.setup({
			dateField      : 'from',
			triggerElement : 'from'
		});
		Calendar.setup({
			dateField      : 'to',
			triggerElement : 'to'    
		});
	}
	</script>
  <div>
		<p>
			<h3>Transaction log for account <a href="account.php?account_id={$account_id}">'{$account_name}'</a> (ID:{$account_id})</h3>
		</p>
    <form action="" method="GET">
    <input type="hidden" name="account_id" value="{$account_id}" />
    <p>From: <input type="text" name="from" id="from" value="{$from}"/><!--<span class="calendarButton" id="fromButton" >..</span>-->
    	To: <input type="text" name="to" id="to" value="{$to}" /><!--<span class="calendarButton" id="toButton" >..</span>-->
    <input type="submit" value="Show" /></p>
    </form>
    <table cellpadding="5" cellspacing="0" border="1">
    {if !count($log) }
      <h2>No transactions found</h2>
    {else}
      <tr><th>Date and time</th><th>Transaction Amount</th><th>Transaction Details</th><th>Via</th></tr>
      <tr><td colspan="4">
      {if count($log) == $perpage}
        <a style="float: right" href="?account_id={$account_id}&page={$page+1}{$from_to}">next &gt;&gt;&gt;</a>
      {else}
        <span style="color: silver; float: right">next &gt;&gt;&gt;</span>
      {/if}
      {if $page > 0}
        <a style="float: left" href="?account_id={$account_id}&page={$page-1}{$from_to}">&lt;&lt;&lt;prev</a>
      {else}
        <span style="color: silver; float: left">&lt;&lt;&lt;prev</span>
      {/if}
      <span style="float: left; margin: 0 2em 0 1em;">Page {$page+1}</span>
      </td></tr>
      {foreach from=$log item=tr}
      <tr valign="top">
        <td>{$tr.date_time}</td><td align="center">{preg_replace("/^(-?)/","$1$",sprintf("%.2f",$tr.amount),1)}</td>
        <td>{$tr.message}{$tr.details}</td><td>{$tr.engine_slug}</td></tr>
      {/foreach}
      <tr><td colspan="4">
      {if count($log) == $perpage}
        <a style="float: right" href="?account_id={$account_id}&page={$page+1}{$from_to}">next &gt;&gt;&gt;</a>
      {else}
        <span style="color: silver; float: right">next &gt;&gt;&gt;</span>
      {/if}
      {if $page > 0}
        <a style="float: left" href="?account_id={$account_id}&page={$page-1}{$from_to}">&lt;&lt;&lt;prev</a>
      {else}
        <span style="color: silver; float: left">&lt;&lt;&lt;prev</span>
      {/if}
      <span style="float: left; margin: 0 2em 0 1em;">Page {$page+1}</span>
      </td></tr>
      </table>
    {/if}
  </div>
	{/if}
