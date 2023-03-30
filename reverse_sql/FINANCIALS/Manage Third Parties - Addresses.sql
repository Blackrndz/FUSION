/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT hzPATIESE0.PARTY_NAME RES_PARTY_NAME
,hz_format_pub.format_address(p_location_id => hzPARTYSITE0.LOCATION_ID, p_line_break => ',') RES_ADDRESS
,hzPARTYSITE0.PARTY_SITE_NUMBER RES_SITE_NUMBER

,hzPARTYSITE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hzPARTYSITE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hzPARTYSITE0.CREATED_BY RSC_CREATED_BY
,hzPARTYSITE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM HZ_PARTIES hzPATIESE0
,HZ_PARTY_USG_ASSIGNMENTS hzPARTYUSEASSE0
,HZ_PARTY_SITES hzPARTYSITE0
,HZ_LOCATIONS hzLOCATIONE0


WHERE hzPATIESE0.PARTY_ID = hzPARTYUSEASSE0.PARTY_ID 
AND hzPARTYUSEASSE0.PARTY_ID = hzPARTYSITE0.PARTY_ID
AND hzPARTYSITE0.LOCATION_ID = hzLOCATIONE0.LOCATION_ID
AND hzPARTYSITE0.STATUS = 'A'
AND hzPARTYUSEASSE0.PARTY_USAGE_CODE IN ('PAYMENT_ISSUING_AUTHORITY','PENSION_PROVIDER','PROFESSIONAL_BODY','BARGAINING_ASSOCIATION','DISABILITY_ORGANIZATION','EXTERNAL_PAYEE')
ORDER BY hzPATIESE0.PARTY_NAME
