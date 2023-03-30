/* ****************************************************************************
 * $Revision: 78666 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-06 16:16:25 +0700 (Mon, 06 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Calculation%20Value%20Definitions%20-%20Calculation%20Value%20Definition.sql $:
 * $Id: Manage Calculation Value Definitions - Calculation Value Definition.sql 78666 2022-06-06 09:16:25Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT payVALUEDEFIEO.NAME RES_NAME
,legislativesE0.NAME RES_LEGISLATIVE_DATA_GROUP
,TO_CHAR(payVALUEDEFIEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,payVALUEDEFIEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payVALUEDEFIEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payVALUEDEFIEO.CREATED_BY RSC_CREATED_BY
,payVALUEDEFIEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,payVALUEDEFIEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM PAY_VALUE_DEFINITIONS_VL payVALUEDEFIEO
,PER_LEGISLATIVE_DATA_GROUPS_VL legislativesE0
WHERE /*SYSDATE BETWEEN payVALUEDEFIEO.EFFECTIVE_START_DATE AND NVL(payVALUEDEFIEO.EFFECTIVE_END_DATE ,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND*/ payVALUEDEFIEO.PARENT_VALUE_DEFN_ID IS NULL
AND payVALUEDEFIEO.LEGISLATION_CODE = legislativesE0.LEGISLATION_CODE
ORDER BY payVALUEDEFIEO.NAME
,legislativesE0.NAME