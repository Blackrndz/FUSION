/* ****************************************************************************
 * $Revision: 55909 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-06-15 11:22:50 +0700 (Wed, 15 Jun 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Manage%20Trading%20Community%20Source%20Systems%20-%20Manage%20Trading%20Community%20Source%20Systems.sql $:
 * $Id: Manage Trading Community Source Systems - Manage Trading Community Source Systems.sql 55909 2016-06-15 04:22:50Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT OriginalSystemEO.ORIG_SYSTEM RES_CODE
,OriginalSystemEO.ORIG_SYSTEM_NAME RES_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'HZ_ORIG_SYSTEM_TYPE'
	AND LOOKUP_CODE = Originalsystemeo.ORIG_SYSTEM_TYPE
	) RES_TYPE
,Originalsystemeo.DESCRIPTION RES_DESCRIPTION
,(DECODE(Originalsystemeo.ENABLE_FOR_ITEMS_FLAG,'Y','Yes','No')) RES_ENABLE_FOR_ITEMS
,(DECODE(OriginalSystemEO.ENABLE_FOR_TCA_FLAG,'Y','Yes','No')) RES_ENABLE_FOR_TRADING_COMMUNI
,(DECODE(Originalsystemeo.ENABLE_FOR_PLANNING_FLAG,'Y','Yes','No')) RES_ENABLE_FOR_ORDER_ORCHESTRA
,(DECODE(OriginalSystemEO.ENABLE_FOR_ASSET_FLAG,'Y','Yes','No')) RES_ENABLE_FOR_ASSETS
,OriginalSystemEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,OriginalSystemEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,OriginalSystemEO.CREATED_BY RSC_CREATED_BY
,OriginalSystemEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,Null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

From Hz_Orig_Systems_Vl Originalsystemeo
order by OriginalSystemEO.ORIG_SYSTEM