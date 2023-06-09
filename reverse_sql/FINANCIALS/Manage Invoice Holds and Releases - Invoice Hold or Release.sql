/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Invoice%20Holds%20and%20Releases%20-%20Invoice%20Hold%20or%20Release.sql $:
 * $Id: Manage Invoice Holds and Releases - Invoice Hold or Release.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


select PAYABLESLOOKUPPEO2.DISPLAYED_FIELD RES_TYPE
,PAYABLESLOOKUPPEO.DISPLAYED_FIELD  RES_NAME
,PAYABLESLOOKUPPEO.DESCRIPTION RES_DESCRIPTION 
,TO_CHAR(APHOLDCODES.INACTIVE_DATE,'DD-Mon-YYYY') RES_INACTIVE_DATE
,decode(APHOLDCODES.POSTABLE_FLAG,'Y','Yes','No') RES_ALLOW_ACCOUNTING
,decode(APHOLDCODES.USER_RELEASEABLE_FLAG,'Y','Yes','No') RES_ALLOW_MANUAL_RELEASE
,decode(APHOLDCODES.INITIATE_WORKFLOW_FLAG,'Y','Yes','No') RES_ALLOW_HOLDS_RESOLUTION_ROU
,APHOLDCODES.WAIT_BEFORE_NOTIFY_DAYS RES_DAYS_BEFORE_NOTIFYING
,APHOLDCODES.REMINDER_DAYS RES_DAYS_BEFORE_REMINDING
,ApHoldCodes.HOLD_INSTRUCTION RES_HOLD_INSTRUCTION
,ApHoldCodes.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ApHoldCodes.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ApHoldCodes.CREATED_BY  RSC_CREATED_BY
,ApHoldCodes.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_HOLD_CODES ApHoldCodes
,AP_LOOKUP_CODES PAYABLESLOOKUPPEO
,AP_LOOKUP_CODES PayablesLookupPEO2
where APHOLDCODES.HOLD_LOOKUP_CODE = PAYABLESLOOKUPPEO.LOOKUP_CODE
and ApHoldCodes.HOLD_TYPE = PayablesLookupPEO2.LOOKUP_CODE
and PAYABLESLOOKUPPEO.LOOKUP_TYPE  = 'HOLD CODE'
and PAYABLESLOOKUPPEO2.LOOKUP_TYPE = 'HOLD TYPE'
ORDER BY PayablesLookupPEO.DISPLAYED_FIELD