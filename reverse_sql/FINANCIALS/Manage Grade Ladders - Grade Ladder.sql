/* ****************************************************************************
 * $Revision: 73701 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-03-05 12:34:33 +0700 (Thu, 05 Mar 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Remittance%20Bank%20Account.sql $:
 * $Id: Manage Receipt Classes and Methods - Remittance Bank Account.sql 73701 2020-03-05 05:34:33Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT laddersE0.NAME RES_NAME
,laddersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,laddersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,laddersE0.CREATED_BY RSC_CREATED_BY
,laddersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT NAME
	,ROW_NUMBER() OVER(PARTITION BY NAME ORDER BY CREATION_DATE) R1
	,LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
	FROM PER_GRADE_LADDERS_F_VL 
	) laddersE0
WHERE R1 = 1
ORDER BY laddersE0.NAME