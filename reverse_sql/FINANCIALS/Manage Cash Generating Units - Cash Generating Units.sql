/* ****************************************************************************
* $Revision: 74359 $:
* $Author: tanawat.wongjan $:
* $Date: 2020-07-20 16:16:20 +0700 (Mon, 20 Jul 2020) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Seniority%20Dates%20-%20Seniority%20Date%20Rule%20List.sql $:
* $Id: Configure Seniority Dates - Seniority Date Rule List.sql 74359 2020-07-20 09:16:20Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT cashGenUnitsE0.CASH_GENERATING_UNIT RES_NAME
,cashGenUnitsE0.BOOK_TYPE_CODE RES_BOOK
,cashGenUnitsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(cashGenUnitsE0.DISABLED_FLAG,'N','Yes','Y','No') RES_ENABLED
,cashGenUnitsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cashGenUnitsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cashGenUnitsE0.CREATED_BY RSC_CREATED_BY
,cashGenUnitsE0.CREATION_DATE RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
	
FROM FA_CASH_GEN_UNITS cashGenUnitsE0
,FA_BOOK_CONTROLS FaBookControlsE0
,(select RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')
	) PGL
WHERE cashGenUnitsE0.BOOK_TYPE_CODE = FaBookControlsE0.BOOK_TYPE_CODE
AND FaBookControlsE0.SET_OF_BOOKS_ID = PGL.TARGET_LEDGER_ID(+)
ORDER BY cashGenUnitsE0.CASH_GENERATING_UNIT